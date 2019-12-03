//
//  ReviewCell.swift
//  Project3Sample
//
//  Created by Cameron Nottingham on 11/30/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell{
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    
    var book: Book?
    var review: Review?
    
}
