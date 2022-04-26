//
//  QuotesAlamofireService.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 22.04.2022.
//

import Foundation
import Alamofire

class QuotesAlamofireService {
    // base API URL (without endpoint) used to make requests from
    private var baseUrl = ""
    
    typealias quotesCallBack = (_ quotes: [Quote]?, _ status: Bool) -> Void
    var callBack: quotesCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getQuotesFrom(endpoint: String) {
        // Make a GET request to the provided endpoint of the API.
        AF.request(
            self.baseUrl + endpoint,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            interceptor: nil).response {
                // Handle response.
                (responseData) in
                guard let data = responseData.data else {
                    // Callback, set status to false.
                    self.callBack?(nil, false)
                    return
                }
                do {
                    // Using Codable, decode countries data.
                    let quotes = try JSONDecoder().decode([Quote].self, from: data)
                    self.callBack?(quotes, true)
                } catch {
                    // Callback, set status to false.
                    self.callBack?(nil, false)
                }
            }
    }
    
    // Provide closure to the request.
    func completionHandler(callBack: @escaping quotesCallBack) {
        self.callBack = callBack
    }
}
