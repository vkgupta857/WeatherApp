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
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    var isSearching = false
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initVM()
        setupUI()
        
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            if let currentLocation = locManager.location {
                debugPrint(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            } else {
                return
            }
        }
    }
    
    func initVM() {
        viewModel.updateSearchResults = {
            // reload table with search result
            debugPrint("cftvg")
        }
    }
    
    func setupUI() {
        self.navigationItem.titleView = searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = StringConstants.searchBarPlaceHolder
        
        
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        if let searchText = searchBar.text, !searchText.isEmpty, searchText.count >= 3 {
            viewModel.searchCities(searchText)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please enter 3 or more characters", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            isSearching = false
        }
        self.searchTableView.reloadData()
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
                        weatherInfoVC.viewModel.latitude = currentLocation.coordinate.latitude
                        weatherInfoVC.viewModel.longitude = currentLocation.coordinate.longitude
                    } else {
                        weatherInfoVC.viewModel.latitude = Constants.defaultLatitude
                        weatherInfoVC.viewModel.longitude = Constants.defaultLongitude
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
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
        }
        self.searchTableView.reloadData()
    }
}
