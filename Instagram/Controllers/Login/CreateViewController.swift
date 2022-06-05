//
//  CreateViewController.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit
import FirebaseAuth
import Firebase

class CreateViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createButton(_ sender: Any) {
        
        if username.text != "" && password.text != "" {
            Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (data, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    
                    self.performSegue(withIdentifier: "creatLogin", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Error", message: "Email or password??")
        }
    }
    func makeAlert (title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }

}
