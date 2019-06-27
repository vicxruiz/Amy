//
//  WelcomeViewController.swift
//  Amy
//
//  Created by Victor  on 6/25/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit

class WelcomeController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = Service.buttonCornerRadius
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = Service.buttonCornerRadius
    }

    
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignIn", sender: self)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = UIColor.groupTableViewBackground
    }
}

