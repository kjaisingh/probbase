//
//  UserInfoViewController.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/22/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class UserInfoViewController: UIViewController {

    @IBOutlet var emailDisplay: UILabel!
    @IBOutlet var suggestionField: UITextView!
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userId = FIRAuth.auth()?.currentUser?.email as! String
        emailDisplay.text = userId
        suggestionField.text = ""
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        let sentText = suggestionField.text
        if(sentText != "") {
            let databaseRef = FIRDatabase.database().reference()
            let suggestion = ["User": userId, "Suggestion": sentText]
            databaseRef.child("Suggestions").childByAutoId().setValue(suggestion)
            self.performSegue(withIdentifier: "finishSuggestion", sender: self)
        }
    }
}
