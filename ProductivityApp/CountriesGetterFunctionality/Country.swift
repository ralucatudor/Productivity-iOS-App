//
//  Country.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 09.04.2022.
//

import Foundation

// Based on response from https://restcountries.com/v2/all

struct Country: Decodable {
    var name: String?
    var capital: String?
    var countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case capital = "capital"
        case countryCode = "alpha3Code"
    }
}
