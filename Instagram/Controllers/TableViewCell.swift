//
//  TableViewCell.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imageView: [UIImageView]!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
