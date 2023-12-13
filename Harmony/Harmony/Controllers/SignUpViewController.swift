//
//  SignUpViewController.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/2/23.
//
import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    let randomNumber = Int.random(in: 1...10000)
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    
        
        do {
            let userNumber = Int(randomNumber)
            // Validate text fields
            guard let userName = name.text, !userName.isEmpty,
                  let userPassword = password.text, !userPassword.isEmpty,
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
            
            if allUsers.contains(where: {$0.name == userName}) && allUsers.contains(where: {$0.userId == randomNumber}){
                Helper.showAlert(from: self, with: "Username \(userName) already exists. Please choose different one.")
                return
            }
            
            // Insert a new user into the database
            try db.insertUser(userId: userNumber, name: userName, email: userEmail, password: userPassword)
            
            Helper.showAlert(from: self,  with: "signed up successfully. Please move in to Login section")
            
            
        }
        catch {
            print("Error adding user: \(error)")
            Helper.showAlert(from: self, with: "Error adding user. Please try again.")
        }
        
    }
    
    

    
    

}
