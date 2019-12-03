//
//  BookDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookPublicationYearLabel: UILabel!
    
    
    var bookCoverImage = UIImage()
    var bookTitle = String()
    var bookPublicationYear = String()
    var bookAuthor = String()
    
    override func viewWillAppear(_ animated: Bool) {
        
        bookCoverImageView.image = bookCoverImage
        bookTitleLabel.text = bookTitle
        bookPublicationYearLabel.text = bookPublicationYear
        bookAuthorLabel.text = bookAuthor
      
        
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    
    
    
}
