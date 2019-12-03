//
//  ReviewDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    
    @IBOutlet weak var reviewText: UITextView!
    
    var reviewTitle = String()
    var reviewAuthor = String()
    var review = String()
    
    override func viewWillAppear(_ animated: Bool) {
        reviewTitleLabel.text = reviewTitle
        reviewAuthorLabel.text = "By " + reviewAuthor
        reviewText.text = review
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
