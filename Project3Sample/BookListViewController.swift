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
    let bookSegueIdentifier = "BookSegue"
    var selectedCell = BookCell()
    
    
    override func viewDidLoad() {
        tableOfBooks.dataSource = self
        tableOfBooks.allowsSelection = true
        tableOfBooks.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableOfBooks.refreshControl = refreshControl
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        fetchBooks()
       
    }
    
    @objc func addTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookInputViewController") as! BookInputViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == bookSegueIdentifier,
            let destination = segue.destination as? BookDetailViewController
        {
            selectedCell = tableOfBooks.cellForRow(at: tableOfBooks.indexPathForSelectedRow!) as! BookCell
            destination.bookCoverImage = selectedCell.bookCoverImage.image ?? UIImage(imageLiteralResourceName: "notfound.png")
            destination.bookTitle = selectedCell.book?.title ?? ""
            destination.bookAuthor = selectedCell.book?.author ?? ""
            destination.bookPublicationYear = selectedCell.book?.published ?? ""
        }
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

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        
    }
   
}


    

