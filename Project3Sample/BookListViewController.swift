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
        fetchBooks()
       
    }
    
    func fetchBooks() {
        bookService.fetchBooks { [weak self] in
            print(String(describing: self?.bookService.books))
            DispatchQueue.main.async {
                self?.tableOfBooks.reloadData()
        }
        }
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookService.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfBooks.dequeueReusableCell(withIdentifier: "BookCell")!
        let book = bookService.books[indexPath.item]
        let bookTitle = book.title
        
        if let bookCell = cell as? BookCell{
            bookService.image(for: book) { (retrievedBook, image) in
                          if book.id == retrievedBook.id {
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
    

