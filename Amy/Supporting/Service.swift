//
//  Service.swift
//  Amy
//
//  Created by Victor  on 6/27/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
class Service {
    static let baseColor = UIColor(r: 254, g: 202, b: 64)
    static let darkBaseColor = UIColor(r: 240, g: 128, b: 128)
    static let unselectedItemColor = UIColor(r:173, g: 173, b: 173)
    
    static let buttonTitleFontSize: CGFloat = 18
    static let buttonTitleColor = UIColor.white
    static let buttonBackgroundColorSignInAnonymously = UIColor(r: 240, g: 128, b: 128)
    static let buttonBackgroundColorSignUp = UIColor(r: 54, g: 54, b: 54)
    static let buttonBackgroundColorSignInWithFacebook = UIColor(r: 89, g: 86, b: 214)
    static let buttonCornerRadius: CGFloat = 7
    static func showAlert(on: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [ UIAlertAction(title: "OK", style: .default, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: completion)
    }
    
    static func dissmissHud(_ hud: JGProgressHUD, text: String, detailText: String, delay: TimeInterval) {
        hud.textLabel.text = text
        hud.detailTextLabel.text = detailText
        hud.dismiss(afterDelay: delay, animated: true)
    }
    
}
