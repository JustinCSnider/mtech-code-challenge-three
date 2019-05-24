//
//  SearchItem.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/20/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

struct SearchItem: Codable {
    
    var title: String
    var moviePosterImageURL: URL?
    var year: String
    var favorited: Bool
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case moviePosterImageURl = "Poster"
        case year = "Year"
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    static func saveToFile(searchItems: [SearchItem]) {
        let propertyListEncoder = PropertyListEncoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("searchItems").appendingPathExtension("plist")
        
        let encodedMeals = try? propertyListEncoder.encode(searchItems)
        
        try? encodedMeals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [SearchItem]? {
        let propertyListDecoder = PropertyListDecoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("searchItems").appendingPathExtension("plist")
        
        if let retrievedSearchData = try? Data(contentsOf: archiveURL), let decodedSearchItems = try? propertyListDecoder.decode(Array<SearchItem>.self, from: retrievedSearchData) {
            return decodedSearchItems
        }
        
        return nil
    }
    
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.year = try valueContainer.decode(String.self, forKey: CodingKeys.year)
        let moviePosterImageURLString = try valueContainer.decode(String.self, forKey: CodingKeys.moviePosterImageURl)
        
        self.moviePosterImageURL = URL(string: moviePosterImageURLString)
        self.favorited = false
    }
    
}

struct SearchItems: Codable {
    let Search: [SearchItem]
}
