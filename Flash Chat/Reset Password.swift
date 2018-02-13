//
//  Reset Password.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 12/26/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Reset_Password: UIViewController {

    @IBOutlet var notificationText: UILabel!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationText.text = ""
        notificationText.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestReset(_ sender: Any) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailTextField.text!) { error in
            if error != nil {
                self.notificationText.isHidden = false
                self.notificationText.text = "Email not recognized."
            } else {
                self.notificationText.isHidden = false
                self.notificationText.text = "Check your email for instructions."
            }
        }
    }
}
