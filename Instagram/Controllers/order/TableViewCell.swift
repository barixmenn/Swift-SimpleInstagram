//
//  TableViewCell.swift
//  Instagram
//
//  Created by macbook on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        like.text = ""
        comment.text = ""
        username.text = ""
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeButton(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(like.text!) {
            let likeStore = ["likes": likeCount + 1 ] as  [String: Any]
            firestoreDatabase.collection("Post").document(idLabel.text!).setData(likeStore, merge: true)
            
        }
    }
}
