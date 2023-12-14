//
//  LoginViewController.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/2/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let db = DataStorageManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getGuestUserCredentials(_ sender: Any) {
        let guestUser = db.retrieveUsers().first(where: { $0.userId == 100 })

            if let guestUser = guestUser {
                email.text = guestUser.email
                password.text = guestUser.password
            } else {
                // Handle the case when the guest user with userId 100 is not found
                print("Guest user not found.")
            }
    }
    
    @IBAction func loginButon(_ sender: Any) {
        
            
            // Validate text fields
            guard let userPassword = password.text, !userPassword.isEmpty,
                  let userEmail = email.text, !userEmail.isEmpty else {
                Helper.showAlert(from: self, with: "Fill all fields to continue.")
                return
            }
            

            // Check for valid email format using regular expression
            if !Helper.isValidEmail(email: userEmail) {
                Helper.showAlert(from: self, with: "Incorrect email format.")
                return
            }
            
            let db = DataStorageManager.shared
            
            let allUsers = db.retrieveUsers()
        
        
            
        // Check if there's a user with matching email and password
            if let user = allUsers.first(where: { $0.email == userEmail && $0.password == userPassword }) {
                // Successful login
                navigateToHomeViewController(user: user)
            } else {
                // Incorrect email or password
                Helper.showAlert(from: self, with: "Invalid email or password.")
            }
        
    }
    
    // Function to navigate to HomeViewController within UITabBarController
    private func navigateToHomeViewController(user: User) {
        if let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarControllerIdentifier") as? UITabBarController {
            if let navController = tabBarController.viewControllers?.first as? UINavigationController {
                // Access the UINavigationController within the UITabBarController
                
                if let homeVC = navController.topViewController as? HomeViewController {
                    // Pass the user object to the HomeViewController
                    homeVC.currentUser = user
                }
            }
            
            // Set the tabBarController as the root view controller
            UIApplication.shared.windows.first?.rootViewController = tabBarController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        
        
        
    }
}
