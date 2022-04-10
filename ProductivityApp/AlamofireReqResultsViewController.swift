//
//  AlamofireReqResultsViewController.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 09.04.2022.
//

import UIKit

class AlamofireReqResultsViewController: UIViewController {

    @IBOutlet weak var tblCountries: UITableView!
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCountries.dataSource = self

        let alamofireService = AlamofireService(
            baseUrl: "https://restcountries.com/v2/")
        alamofireService.getAllCountryNamesFrom(endpoint: "all")
        
        alamofireService.completionHandler { [weak self] (countries, status, message) in
            if status {
                guard let self = self else { return }
                guard let _countries = countries else { return }
                self.countries = _countries
                self.tblCountries.reloadData()
            }
        }
    }
}

extension AlamofireReqResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "countrycell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "countrycell")
        }
        
        let country = countries[indexPath.row]
        
        cell?.textLabel?.text = (country.name ?? "") + " " + (country.countryCode ?? "")
        cell?.detailTextLabel?.text = country.capital ?? ""
        return cell!
    }
}
