//
//  Quote.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 22.04.2022.
//

import Foundation

// Based on response from https://zenquotes.io/api/quotes
struct Quote: Decodable {
    var quote: String?
    var author: String?
    
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
    }
}
