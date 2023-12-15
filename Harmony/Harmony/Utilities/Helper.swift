//
//  Helper.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/12/23.
//

import Foundation
import UIKit

class Helper {
    static let dateFormatter = DateFormatter()
    
    static func showAlert(from viewController: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // Function to validate email format using regular expression
     static func isValidEmail(email: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
       }
    
    static func showAlertforCall(_ alert: UIAlertController) {
            if let topController = topMostViewController() {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    
    static func topMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        return base
    }

    
    
}
