import UIKit
import Firebase
import FirebaseAuth

class WelcomeViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
