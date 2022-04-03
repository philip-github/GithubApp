//
//  CustomXIBTableViewCell.swift
//  GitHubApp
//
//  Created by Philip Twal on 4/3/22.
//

import UIKit

class CustomXIBTableViewCell: UITableViewCell {
    
    static let identifier = "CustomXIBTableViewCell"
    
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var shaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
