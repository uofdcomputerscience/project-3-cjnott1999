//
//  BookListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    //Outlets
    @IBOutlet var tableOfBooks: UITableView!
    
    //Fields
    let bookService = BookService.shared
    let bookSegueIdentifier = "BookSegue"
    var selectedCell = BookCell()
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    
    //Sets up the current ViewController
    func setUpViewController() {
        
        //Set the delegates and Data Sources
        tableOfBooks.dataSource = self
        tableOfBooks.delegate = self
        
        //Set up the Refresh Controller
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableOfBooks.refreshControl = refreshControl
        
        //Add the navigation + button to the right side of the control bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        //Fetch the books from the service
        fetchBooks()
        
        
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
            destination.bookId = selectedCell.book!.id!
        }
    }


    //Fetch books from the BookService and reload the tableView
    func fetchBooks() {
        bookService.fetchBooks { [weak self] in

            DispatchQueue.main.async {
                self?.tableOfBooks.reloadData()
        }
        }
    }
    
    //When the refresh controller is called by pulling down, refresh
    @objc func refresh(_ refreshControl: UIRefreshControl){
      bookService.fetchBooks { [weak self] in
              DispatchQueue.main.async {
                  self?.tableOfBooks.reloadData()
                  refreshControl.endRefreshing()
          }
        }
    }
    
    //When the + button is tapped, present a BookInputViewController
    @objc func addTapped(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookInputViewController") as! BookInputViewController
        self.present(vc, animated: true, completion: nil)
        
    }
}


//DataSources and Delegates
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
                                bookCell.bookCoverImage.image = image ?? UIImage(imageLiteralResourceName: "notfound")
                                
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



    

