//
//  BookDetailsTableViewCell.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 29/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

class BookDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageView_Book: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Details: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var view_Background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.view_Background.layer.borderWidth = 1.0
        self.view_Background.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
