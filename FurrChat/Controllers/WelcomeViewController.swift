//
//  ViewController.swift
//  FurrChat
//
//  Created by Yogalakshmi Balasubramaniam on 5/25/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        let titleText = K.appName
        var i = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * i, repeats: false) { Timer in
                self.titleLabel.text?.append(letter)
            }
            i += 1
        }
    }
}

