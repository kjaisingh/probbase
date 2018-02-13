//
//  ChangePasswordViewController.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/22/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var successNotice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successNotice.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        SVProgressHUD.show()
        FIRAuth.auth()?.currentUser?.updatePassword(newPassword.text!, completion: { (error) in
            if error != nil {
                print (error)
            } else {
                SVProgressHUD.dismiss()
                self.successNotice.isHidden = false
            }
        })
    }
    
}
