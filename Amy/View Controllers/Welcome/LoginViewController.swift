//
//  LoginViewController.swift
//  Amy
//
//  Created by Victor  on 6/25/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit
import LBTAComponents
import FirebaseAuth
import JGProgressHUD
import FirebaseStorage
import FirebaseDatabase

class SignInController: UIViewController {
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "forgot", sender: self)
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 7
        self.hideKeyboardWhenTappedAround()
    }
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        hud.textLabel.text = "Signing In..."
        hud.show(in: view, animated: true)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.hud.dismiss(animated: true)
                print("Failed to sign in with error", error)
                Service.showAlert(on: self, style: .alert, title: "Sign In Error", message: error.localizedDescription)
                return
            }
            self.hud.dismiss(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func textFieldShouldReturn(emailField: UITextField) -> Bool {
        
        emailField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = UIColor.groupTableViewBackground
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

