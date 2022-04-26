//
//  QuoteViewController.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 21.04.2022.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet weak var tblQuotes: UITableView!
    var quotes = [Quote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblQuotes.dataSource = self

        // Set-up the service for requests.
        let quotesAlamofireService = QuotesAlamofireService(
            baseUrl: "https://zenquotes.io/api/")
        quotesAlamofireService.getQuotesFrom(endpoint: "quotes")
        
        quotesAlamofireService.completionHandler { [weak self] (quotes, status) in
            // If countries have been successfully received,
            if status {
                // then set the `countries` global variable.
                guard let self = self else { return }
                guard let _quotes = quotes else { return }
                self.quotes = _quotes
                self.tblQuotes.reloadData()
            }
        }
    }
}

extension QuoteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle,
                                                    reuseIdentifier: "cell")

        let quote = quotes[indexPath.row]
        
        cell.textLabel?.text = (quote.quote ?? "")
        cell.detailTextLabel?.text = quote.author ?? ""
        return cell
    }
}
