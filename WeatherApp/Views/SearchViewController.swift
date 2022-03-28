//
//  ViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var cellIdentifier = "SearchTableViewCell"
    
    var isSearching = false
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = StringConstants.searchBarPlaceHolder
    
        
        
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
}

// MARK: table view delegate methods
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return 1
        } else {
            switch section {
            case 0:
                return 3
            default:
                return 5
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return SearchTableCellType.suggestions.rawValue
        } else {
            switch section {
            case 0:
                return SearchTableCellType.recentSearch.rawValue
            default:
                return SearchTableCellType.topCities.rawValue
            }
        }
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchTableViewCell {
            if isSearching {
                if indexPath.row == 0 {
                    cell.cellImage.image = UIImage(systemName: UIConstants.currentLocation)
                    cell.cityName.text = "Current Location"
                } else {
                    cell.cellImage.image = UIImage(systemName: UIConstants.searchedCitiesImage)
                    cell.cityName.text = "City \(indexPath.row + 1)"
                }
            } else {
                switch indexPath.section {
                case 0:
                    cell.cellImage.image = UIImage(systemName: UIConstants.recentSearchImage)
                    cell.cityName.text = "City \(indexPath.row + 1)"
                default:
                    if indexPath.row == 0 {
                        cell.cellImage.image = UIImage(systemName: UIConstants.currentLocation)
                        cell.cityName.text = StringConstants.currentLocationText
                    } else {
                        cell.cellImage.image = UIImage(systemName: UIConstants.topCitiesImage)
                        cell.cityName.text = "City \(indexPath.row + 1)"
                    }
                }
            }
            return cell
        } else {
            return SearchTableViewCell()
        }
    }
    
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.searchTableView.cellForRow(at: indexPath) as? SearchTableViewCell
        if let cityName = cell?.cityName.text, let weatherInfoVC = UIStoryboard(name: UIConstants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: UIConstants.weatherInfoVC) as? WeatherInfoViewController {
            if cityName == StringConstants.currentLocationText {
                locManager.requestWhenInUseAuthorization()
                
                if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                        CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
                    if let currentLocation = locManager.location {
                        weatherInfoVC.latitude = currentLocation.coordinate.latitude
                        weatherInfoVC.longitude = currentLocation.coordinate.longitude
                    } else {
                        weatherInfoVC.latitude = Constants.defaultLatitude
                        weatherInfoVC.longitude = Constants.defaultLongitude
                        weatherInfoVC.navigationTitle = Constants.defaultCityName
                    }
                }
            } else {
                weatherInfoVC.navigationTitle = cityName
            }
            self.navigationController?.pushViewController(weatherInfoVC, animated: true)
        }
    }
}

// MARK: searchBar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
        } else {
            isSearching = true
        }
        self.searchTableView.reloadData()
    }
}
