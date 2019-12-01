//
//  Book.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import Foundation

struct Book: Codable {
    let id: Int?
    let title: String
    let author: String
    let published: String
    let imageURLString: String?
    
   var imageURL: URL? {
          if let url = imageURLString {
              return URL(string: url)
          }
          else {
              return URL(string: "https://www.lahsa.org/service/get-image?id=114d4059-8929-4bbf-bd02-a7c8b1aa1310.jpg")
          }
    }
}
