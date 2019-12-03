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
    let reviewSegue = "ReviewSegue"
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()

        
    }
    
    //Sets up the current ViewController
    func setUpViewController(){
        
        //Set delegates and DataSources
        reviewsTable.dataSource = self
        reviewsTable.delegate = self
        
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        reviewsTable.refreshControl = refreshControl
        
        fetchReviews()
    }
    
    
    func fetchReviews() {
           reviewService.fetchReviews { [weak self] in
               DispatchQueue.main.async {
                self?.reviewsTable.reloadData()
            }
           }
       }
    
    @objc func refresh(_ refreshControl: UIRefreshControl){
      reviewService.fetchReviews{ [weak self] in

              DispatchQueue.main.async {
                  self?.reviewsTable.reloadData()
                  refreshControl.endRefreshing()
          }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == reviewSegue,
            let destination = segue.destination as? ReviewDetailViewController
        {
           let selectedCell = reviewsTable.cellForRow(at: reviewsTable.indexPathForSelectedRow!) as! ReviewCell
            
            destination.reviewAuthor = selectedCell.review!.reviewer
            destination.reviewTitle = selectedCell.review!.title
            destination.review = selectedCell.review!.body
            destination.reviewDate = selectedCell.review!.date
            
        }
    }
    

}

extension ReviewListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewService.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTable.dequeueReusableCell(withIdentifier: "ReviewCell")!
        let review = reviewService.reviews[indexPath.item]
        let book = bookService.books.first(where: {$0.id == review.bookId})
        
        if let reviewCell = cell as? ReviewCell{
            reviewCell.book = book
            reviewCell.review = review
            bookService.image(for: book!) { (retrievedBook, image) in
                if reviewCell.book?.id == retrievedBook.id {
                              DispatchQueue.main.async {
                                reviewCell.bookCoverImageView.image = image
                                reviewCell.bookTitleLabel.text = book!.title
                                reviewCell.reviewAuthorLabel.text = review.reviewer
                              }
                          }
                      }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
          
      }
    
    
    
}
