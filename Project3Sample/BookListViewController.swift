//
//  BookListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet var tableOfBooks: UITableView!
    let bookService = BookService.shared
    
    
    override func viewDidLoad() {
        tableOfBooks.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableOfBooks.refreshControl = refreshControl
        
        
        fetchBooks()
       
    }


    
    func fetchBooks() {
        bookService.fetchBooks { [weak self] in

            DispatchQueue.main.async {
                self?.tableOfBooks.reloadData()
        }
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl){
      bookService.fetchBooks { [weak self] in

              DispatchQueue.main.async {
                  self?.tableOfBooks.reloadData()
                  refreshControl.endRefreshing()
          }
        
          }
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookService.books.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier:"BookCell")!
        let book = bookService.books[indexPath.item]
        let bookTitle = book.title
        
        if let bookCell = cell as? BookCell{
            bookCell.book = book
            bookService.image(for: book) { (retrievedBook, image) in
                if bookCell.book?.id == retrievedBook.id {
                              DispatchQueue.main.async {
                                bookCell.bookCoverImage.image = image
                                bookCell.bookTitleLabel.text = bookTitle
                              }
                          }
                      }
        }
        
        return cell
      
    }
}
    

