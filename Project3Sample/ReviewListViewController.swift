//
//  ReviewListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController {
    
    
    @IBOutlet var reviewsTable: UITableView!
    let reviewService = ReviewService.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTable.dataSource = self
        fetchReviews()
        
    }
    
    
    func fetchReviews() {
           reviewService.fetchReviews { [weak self] in
               print(String(describing: self?.reviewService.reviews))
               DispatchQueue.main.async {
                self?.reviewsTable.reloadData()
            }
           }
       }
    

}

extension ReviewListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewService.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTable.dequeueReusableCell(withIdentifier: "ReviewCell")!
        let review = reviewService.reviews[indexPath.item]
        
        if let reviewCell = cell as? ReviewCell{
            reviewCell.bookAuthorLabel.text = "Author"
            reviewCell.reviewAuthorLabel.text = review.reviewer
            reviewCell.reviewTitleLabel.text = review.title
        }
        
        return cell
    }
    
    
}
