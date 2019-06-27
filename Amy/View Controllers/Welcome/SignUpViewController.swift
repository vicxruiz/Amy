//
//  SignUpViewController.swift
//  Amy
//
//  Created by Victor  on 6/25/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import JGProgressHUD
import LBTAComponents
import FirebaseDatabase



class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    
    @IBOutlet weak var signUpAccept: UIButton!
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if self.usernameField.text == "" {
            self.hud.dismiss(animated: true)
            Service.showAlert(on: self, style: .alert, title: "Sign Up Error", message: "Name Field Required")
            return
        }
        guard let name = usernameField.text else {return}
        let nameIsValid = isValidName(testStr: name)
        if !nameIsValid {
            Service.showAlert(on: self, style: .alert, title: "Name Invalid", message: "Please Provide Valid Name")
            return
        }
        
        guard let email = emailField.text else {return}
        let emailIsValid = isValidEmail(testStr: email)
        if !emailIsValid {
            Service.showAlert(on: self, style: .alert, title: "Email Invalid", message: "Please Provide Valid Email")
            return
        }
        guard let password = passwordField.text else {return}
        hud.textLabel.text = "Signing Up..."
        hud.show(in: view, animated: true)
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.hud.dismiss(animated: true)
                print("Failed to sign up with error", error)
                Service.showAlert(on: self, style: .alert, title: "Sign Up Error", message: error.localizedDescription)
                return
            }
            
            
            self.saveUserIntoFirebase()
            self.hud.dismiss(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func isValidName(testStr:String) -> Bool {
        let nameRegEx = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func saveUserIntoFirebase() {
        guard let name = usernameField.text else {return}
        guard let email = emailField.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let dictionaryValues = ["name": name,
                                "email": email]
        
        let databaseRef = Database.database().reference().child("users/\(uid)")
        databaseRef.setValue(dictionaryValues) { error, ref in
            if let error = error {
                print(error)
                return
            }
            print("Successfully saved user to database")
        }
    }
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        signUpAccept.layer.masksToBounds = true
        signUpAccept.layer.cornerRadius = 7
        self.hideKeyboardWhenTappedAround()
        //        usernameField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = UIColor.groupTableViewBackground
    }
    
}
