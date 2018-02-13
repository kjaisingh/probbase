import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController, UITextFieldDelegate {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextfield.delegate = self
        emailTextfield.returnKeyType = UIReturnKeyType.next
        passwordTextfield.delegate = self
        passwordTextfield.tag = 1
        passwordTextfield.returnKeyType = UIReturnKeyType.go
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        self.performSegue(withIdentifier: "goToReset", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
    }
    
    func createAlert(title: String, message: String) {
        let errormsg = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:  { (action) in
            errormsg.dismiss(animated: true, completion: nil)
        }))
        self.present(errormsg, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        FIRAuth.auth()?.signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil{
                if let fberror = FIRAuthErrorCode(rawValue: error!._code){
                    switch fberror {
                    case .errorCodeWrongPassword:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* The password entered is incorrect.")
                        break
                    case .errorCodeInvalidEmail:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* The email entered is invalid.")
                        break
                    case .errorCodeUserNotFound:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* The specified user account does not exist. Please register.")
                        break
                    case .errorCodeEmailAlreadyInUse:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* The specified user is already in use. Please use another email.")
                        break
                    case .errorCodeWeakPassword:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* The password entered must be at least 6 characters long.")
                        break
                    default:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Logging In", message: "* There was a connection problem.")
                        break
                    }
                    print(error)
                }
                
            }
            else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        })
    }
}

