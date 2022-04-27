//
//  PostCell.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 26/04/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postView.layer.cornerRadius = postView.frame.size.height/6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
