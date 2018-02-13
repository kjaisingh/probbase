//
//  SingleQuestion.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/22/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class SingleQuestion: UIViewController {
    
    @IBOutlet var questionField: UITextView!
    var question : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         questionField.text = question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
