//
//  ChatViewController.swift
//  FurrChat
//
//  Created by Yogalakshmi Balasubramaniam on 5/25/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        title = K.appName
        navigationItem.hidesBackButton = true
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error {
                print("Error in reading data from firestore, \(String(describing: e.localizedDescription))")
            
            } else {
                if let SnapshotDoc = querySnapshot?.documents {
                    for docs in SnapshotDoc {
                        let data = docs.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            print(newMessage)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
    }
   
    @IBAction func sendKeyPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("Error saving the data in firestore, \(e.localizedDescription)")
                } else {
                    print("Data saved successfully")
                }
            }
        }
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
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(messages.count)
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    
}

