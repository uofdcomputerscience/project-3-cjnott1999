//
//  BookCell.swift
//  Project3Sample
//
//  Created by Cameron Nottingham on 11/30/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookCell:UITableViewCell {
    
    var book: Book?
    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        book = nil
        bookCoverImage.image = nil
        bookTitleLabel.text = " "
    }
    
    

}
