//
//  MainTabBarController.swift
//  Amy
//
//  Created by Victor  on 6/27/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //checks logged in status of user
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = true
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.tintColor = UIColor.black
    }
}
