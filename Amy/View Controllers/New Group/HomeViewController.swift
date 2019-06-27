//
//  HomeViewController.swift
//  Amy
//
//  Created by Victor  on 6/27/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
class HomeViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUserEmail = Auth.auth().currentUser?.email else {return}
        emailLabel.text = currentUserEmail
    }
}
