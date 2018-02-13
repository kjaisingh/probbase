//
//  ChangeEmailViewController.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/22/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

class ChangeEmailViewController: UIViewController {

    @IBOutlet var userEmail: UITextField!
    
    @IBOutlet var successNotice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successNotice.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func confirmEmail(_ sender: Any) {
        FIRAuth.auth()?.currentUser?.updateEmail(userEmail.text!, completion: { (error) in
            if error != nil {
                print (error)
            } else {
                self.successNotice.isHidden = false
            }
        })
    }
    

}
