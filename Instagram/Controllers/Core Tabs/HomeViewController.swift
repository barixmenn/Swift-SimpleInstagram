//
//  ViewController.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class HomeViewController: UIViewController {
    

        
        var idArray = [String] ()
        var emailArray = [String] ()
        var likesArray = [Int] ()
        var imageArray = [String] ()
        var commentArray = [String] ()
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFirebase()
    }
    
    
    
    private func getDataFirebase () {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true {
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.likesArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.idArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.idArray.append(documentID)
                        
                        
                        if let email = document.get("email") as? String {
                            self.emailArray.append(email)
                        }
                        
                        if let comment = document.get("comment") as? String {
                            self.commentArray.append(comment)
                        }
                        if let like = document.get("likes") as? Int {
                            self.likesArray.append(like)
                        }
                        if let image = document.get("image") as? String {
                            self.imageArray.append(image)
                            print(image)
                        }
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    func makeAlert (title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.username.text = emailArray[indexPath.row]
        cell.comment.text = commentArray[indexPath.row]
        cell.like.text = String(likesArray[indexPath.row])
        cell.imageview.sd_setImage(with: URL(string: imageArray[indexPath.row]))
        cell.idLabel.text = idArray[indexPath.row]
        return cell
    }
}

