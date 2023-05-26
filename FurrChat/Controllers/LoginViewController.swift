//
//  LoginViewController.swift
//  FurrChat
//
//  Created by Yogalakshmi Balasubramaniam on 5/25/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBAction func loginPressed(_ sender: UIButton) {
       
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorMessageLabel.text = e.localizedDescription
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}

