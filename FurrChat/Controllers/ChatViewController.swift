//
//  ChatViewController.swift
//  FurrChat
//
//  Created by Yogalakshmi Balasubramaniam on 5/25/23.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var MessageTextField: UITextField!
    
    override func viewDidLoad() {
        title = K.appName
        navigationItem.hidesBackButton = true
    }
   
    @IBAction func sendKeyPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print("Error in signing out, \(signOutError)")
        }
    }
}

