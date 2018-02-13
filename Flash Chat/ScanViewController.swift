//
//  ScanViewController.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/21/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import SVProgressHUD
import TesseractOCR

class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {

    @IBOutlet var imagePicked: UIImageView!
    @IBOutlet var warningSign: UILabel!
    
    var outputS: String = ""
    var set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }
    
    func showHUD() -> Optional<Any>
    {
        SVProgressHUD.show()
        return true
    }
    
    func createAlert(title: String, message: String) {
        let errormsg = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:  { (action) in
            errormsg.dismiss(animated: true, completion: nil)
        }))
        self.present(errormsg, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoConversion") {
            let destinationVC = segue.destination as! DisplayQuestions
            destinationVC.textPassed = self.outputS
        }
    }
    
    @IBAction func convertPressed(_ sender: Any) {
        let workerQueue = DispatchQueue.global(qos: .userInitiated)
        workerQueue.async{
            if let info = self.showHUD() {
                DispatchQueue.main.async {
                    if((self.imagePicked.image) != nil) {
                        if let tesseract = G8Tesseract(language: "eng") {
                            tesseract.delegate = self as! G8TesseractDelegate
                            let image = self.imagePicked.image!
                            tesseract.image = image.g8_blackAndWhite()
                            tesseract.recognize()
                            self.outputS = tesseract.recognizedText
                            let characters = Array(self.outputS)
                            var finalText: String = ""
                            var count: Int = 0
                            for i in characters {
                                var check: Int = 0
                                if(count != (characters.count-1)) {
                                    if i == "\n" {
                                        let nextChar = String(characters[count + 1])
                                        if self.set.contains(nextChar) {
                                            check = 1
                                            if((String(i)) == "-") {
                                                finalText += " "
                                            }
                                        }
                                    }
                                    if check == 0 {
                                        finalText += String(i)
                                    }
                                    count += 1
                                }
                            }
                            finalText += "\n"
                            self.outputS = finalText 
                            self.performSegue(withIdentifier: "gotoConversion", sender: self)
                        }
                    } else {
                        self.createAlert(title: "Error Converting", message: "An image must be selected.")
                    }
                }
            }
        }
    }
}
