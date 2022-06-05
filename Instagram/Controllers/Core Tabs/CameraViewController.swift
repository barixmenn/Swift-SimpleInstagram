//
//  CameraViewController.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var commentLabel: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosenPhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosenPhoto () {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }

    @IBAction func saveButton(_ sender: Any) {
    
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child(uuid)
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                         
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            let firebaseData = Firestore.firestore()
                            var firebaseReference : DocumentReference? = nil
                            let firestorePost = ["image": imageURL!, "email": Auth.auth().currentUser!.email, "comment": self.commentLabel.text!, "date": FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firebaseReference = firebaseData.collection("Post").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                } else {
                                    self.makeAlert(title: "", message: "Success")
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
     
        


}
    func makeAlert (title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
