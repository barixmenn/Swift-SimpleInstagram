//
//  LoginViewController.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit
import FirebaseAuth



class LoginViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var username: UITextField!
    

    @IBOutlet weak var password: UITextField!
    
   
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
 
        view.backgroundColor = .systemBackground
       
    }
    
    
   
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if username.text != "" && password.text != "" {
            Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (data, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    
                    self.performSegue(withIdentifier: "login", sender: nil)
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



