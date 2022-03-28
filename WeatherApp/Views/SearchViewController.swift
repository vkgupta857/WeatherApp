//
//  ViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            if let currentLocation = locManager.location {
                
            } else {
                return
            }
            print(currentLocation?.coordinate.latitude)
            print(currentLocation?.coordinate.longitude)
        }
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherInfoViewController")
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell {
            cell.cityName.text = "City \(indexPath.row + 1)"
            return cell
        } else {
            return SearchTableViewCell()
        }
    }
    
    
}
