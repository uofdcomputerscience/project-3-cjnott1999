//
//  BookInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookInputViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextField: UITextField!
    @IBOutlet weak var bookPublicationYearTextField: UITextField!
    @IBOutlet weak var bookImageURLTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let bookService = BookService.shared
    
    override func viewDidLoad() {
        bookTitleTextField.delegate = self
        bookAuthorTextField.delegate = self
        bookPublicationYearTextField.delegate = self
        bookImageURLTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        
        view.addGestureRecognizer(tap)
        
        super.viewDidLoad()
    }
    
    @IBAction func sumbitReview(_ sender: Any) {
        let title = bookTitleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let author = bookAuthorTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let published = bookPublicationYearTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let imageURL = bookImageURLTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let book = Book(id: nil, title: title, author: author, published: published, imageURLString: imageURL)
        
        bookService.createBook(book: book) {
                  print("book created")
        }
        self.dismiss(animated: true)
        
    }
    
    func allFieldsFilledIn() -> Bool{
        return !bookTitleTextField.text!.isEmpty && !bookAuthorTextField.text!.isEmpty && !bookPublicationYearTextField.text!.isEmpty && !bookImageURLTextField.text!.isEmpty
    }
    
    func enableSubmitButton() {
        submitButton.isEnabled = allFieldsFilledIn()
    }
    
    
    
}

extension BookInputViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bookTitleTextField {
             bookAuthorTextField.becomeFirstResponder()
         }
        if textField == bookAuthorTextField {
            bookPublicationYearTextField.becomeFirstResponder()
        }
        if textField == bookPublicationYearTextField {
            bookImageURLTextField.becomeFirstResponder()
            
        }
        if textField == bookImageURLTextField {
            bookImageURLTextField.resignFirstResponder()
        }
         return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        enableSubmitButton()
    }
    
    
    
}
