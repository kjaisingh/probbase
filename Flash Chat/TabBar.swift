//
//  TabBar.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/21/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

class TabBar: UITabBarController {

    @IBAction func logoutPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch { //if there is no internet connection, etc.
            print("There was an error signing out.")
        }
        
        guard(navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("To view controllers to pop off")
                return //returns array of all view controllers popped off
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
