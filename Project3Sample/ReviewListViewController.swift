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
    let bookService = BookService.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTable.dataSource = self
        
        fetchReviews()
        
    }
    
    
    func fetchReviews() {
           reviewService.fetchReviews { [weak self] in
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
        let book = bookService.books.first(where: {$0.id == review.bookId})!
        
        if let reviewCell = cell as? ReviewCell{
            reviewCell.book = book
            bookService.image(for: book) { (retrievedBook, image) in
                if reviewCell.book?.id == retrievedBook.id {
                              DispatchQueue.main.async {
                                reviewCell.bookCoverImageView.image = image
                                reviewCell.bookTitleLabel.text = book.title
                                reviewCell.reviewAuthorLabel.text = review.reviewer
                              }
                          }
                      }
        }
        
        return cell
    }
    
    
    
}
