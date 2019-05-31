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
    
    /// For cell's data assinging
    var bookData: BookData = BookData() {
        didSet {
            self.configureCellData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view_Background.layer.borderWidth = 1.0
        self.view_Background.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Assinging data to cell Componets
    private func configureCellData() {
        self.lbl_Title.text = self.bookData.book_title
        self.lbl_Details.text = self.bookData.author_name
        self.lbl_Type.text = self.bookData.genre
        self.imageView_Book.image = nil
        if let url = URL(string: self.bookData.image_url)
        {
            self.imageView_Book.load(url: url)
        }
    }
}
