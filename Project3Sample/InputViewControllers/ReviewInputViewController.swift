//
//  ReviewInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewInputViewController: UIViewController {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    let reviewService = ReviewService.shared
    var bookId = Int()
    var bookTitle = String()
    
    override func viewWillAppear(_ animated: Bool) {
        bookTitleLabel.text = bookTitle
        reviewTextView.text = "Write a review!"
        reviewTextView.textColor = UIColor.lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.reviewTextView.layer.borderWidth = 1
        
        nameTextField.delegate = self
        titleTextField.delegate = self
        reviewTextView.delegate = self
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
              
        view.addGestureRecognizer(tap)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            reviewTextView.contentInset = .zero
        } else {
            reviewTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        reviewTextView.scrollIndicatorInsets = reviewTextView.contentInset

        let selectedRange = reviewTextView.selectedRange
        reviewTextView.scrollRangeToVisible(selectedRange)
    }
    
    func allFieldsFilledIn() -> Bool{
          return !bookTitleLabel.text!.isEmpty && !nameTextField.text!.isEmpty && !titleTextField.text!.isEmpty && !reviewTextView.text!.isEmpty
      }
    
    func enableSubmitButton(){
        submitButton.isEnabled = allFieldsFilledIn()
    }

    @IBAction func submitPressed(_ sender: Any) {
        
        let title = titleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let reviewer = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let body = reviewTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let review = Review(id: nil, bookId: bookId, date: Date(), reviewer: reviewer, title: title, body: body)
        
        reviewService.createReview(review: review) {
            print("review created")
        }
        self.dismiss(animated: true)
    }
    
    
}

extension ReviewInputViewController: UITextViewDelegate, UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
             titleTextField.becomeFirstResponder()
         }
        if textField == titleTextField {
            reviewTextView.becomeFirstResponder()
            
        }
         return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reviewTextView.textColor == UIColor.lightGray {
               reviewTextView.text = nil
               reviewTextView.textColor = UIColor.black
           }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        enableSubmitButton()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        enableSubmitButton()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            reviewTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
  
}
