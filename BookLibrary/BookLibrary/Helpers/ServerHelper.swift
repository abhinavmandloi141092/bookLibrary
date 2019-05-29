//
//  ServerHelper.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 29/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

class ServerHelper {
    
    public var dataModel: Array<BookData> = []
    
    public func getDataFromJSONFile() -> Array<BookData> {
        
        if let path = Bundle.main.path(forResource: "BookDetails", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(jsonResult)
                if let jsonResult = jsonResult as? Array<[String: AnyObject]> {
                    self.dataModel = []
                    for data1 in jsonResult {
                        self.dataModel.append(BookData(JSONDictionary: data1))
                    }
                }
                return self.dataModel
                
            } catch {
                // handle error
                print("Error")
            }
        }
        return self.dataModel
    }
}

struct BookData {
    var author_country: String = ""
    var author_name: String = ""
    var book_title: String = ""
    var genre: String = ""
    var id: String = ""
    var image_url: String = ""
    var publisher: String = ""
    var sold_count: Double = 0
    
    init(JSONDictionary: [String: AnyObject]) {
        
        if let author_country = JSONDictionary["author_country"]?.string {
            self.author_country = author_country
        }
        
        if let author_name = JSONDictionary["author_name"]?.string {
            self.author_name = author_name
        }
        
        if let book_title = JSONDictionary["book_title"]?.string {
            self.book_title = book_title
        }
        
        if let genre = JSONDictionary["genre"]?.string {
            self.genre = genre
        }
        
        if let id = JSONDictionary["id"]?.string {
            self.id = id
        }
        
        if let image_url = JSONDictionary["image_url"]?.string {
            self.image_url = image_url
        }
        
        if let publisher = JSONDictionary["publisher"]?.string {
            self.publisher = publisher
        }
        
        if let sold_count = JSONDictionary["sold_count"]?.doubleValue {
            self.sold_count = sold_count
        }
    }
}
