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
    
    override func viewWillAppear(_ animated: Bool) {
        // get recently searched cities from UserDefaults
        self.viewModel.getRecentCities()
        self.searchTableView.reloadData()
    }
    
    func initVM() {
        viewModel.updateSearchResults = { [weak self] in
            // reload table with search result
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
        
        viewModel.showError = { [weak self] msg in
            // show error msg
            DispatchQueue.main.async {
                self?.showAlert(title: "", message: msg)
            }
        }
        
        viewModel.showCurrentCityWeather = { [weak self] city in
            DispatchQueue.main.async {
                if let weatherInfoVC = UIStoryboard(name: UIConstants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: UIConstants.weatherInfoVC) as? WeatherInfoViewController {
                    weatherInfoVC.viewModel.locationKey = city.key
                    weatherInfoVC.viewModel.latitude = self?.viewModel.latitude
                    weatherInfoVC.viewModel.longitude = self?.viewModel.longitude
                    self?.navigationController?.pushViewController(weatherInfoVC, animated: true)
                }
            }
        }
    }
    
    func setupUI() {
        self.navigationItem.titleView = searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = StringConstants.searchBarPlaceHolder
    }
    
    func showCurrentLocationData() {
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            if let currentLocation = locManager.location {
                self.viewModel.latitude = currentLocation.coordinate.latitude
                self.viewModel.longitude = currentLocation.coordinate.longitude
                self.viewModel.getCityFromGeoLocation()
            } else {
                self.showAlert(title: "Cannot detect location!", message: "Using default location of Nagpur, Maharashtra, India") { [weak self] in
                    self?.showDefaultLocationData()
                }
            }
        }
    }
    
    func showDefaultLocationData() {
        self.viewModel.latitude = Constants.defaultLatitude
        self.viewModel.longitude = Constants.defaultLongitude
        self.viewModel.getCityFromGeoLocation()
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
            return self.viewModel.searchCityResults?.count ?? 0 + 1
        } else if let count = self.viewModel.recentCities?.count, count > 0 {
            switch section {
            case 0:
                return count
            default:
                return Constants.searchCitiesOffset + 1
            }
        } else {
            // return count of current city + my location
            return Constants.searchCitiesOffset + 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else if let count = self.viewModel.recentCities?.count, count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return SearchTableCellType.suggestions.rawValue
        } else if let count = self.viewModel.recentCities?.count, count > 0 {
            switch section {
            case 0:
                return SearchTableCellType.recentSearch.rawValue
            default:
                return SearchTableCellType.topCities.rawValue
            }
        } else {
            return SearchTableCellType.topCities.rawValue
        }
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchTableViewCell {
            if isSearching {
                if indexPath.row == 0 {
                    cell.cellImage.image = UIImage(systemName: UIConstants.currentLocation)
                    cell.cityName.text = StringConstants.currentLocationText
                } else {
                    cell.cellImage.image = UIImage(systemName: UIConstants.searchedCitiesImage)
                    var cellText = ""
                    let index = indexPath.row - 1
                    if let cityName = self.viewModel.searchCityResults?[index].localizedName {
                        cellText += "\(cityName)"
                    }
                    if let stateName = self.viewModel.searchCityResults?[index].administrativeArea?.localizedName {
                        cellText += ", \(stateName)"
                    }
                    if let countryName = self.viewModel.searchCityResults?[index].country?.localizedName {
                        cellText += ", \(countryName)"
                    }
                    cell.cityName.text = cellText
                }
            }  else if let count = self.viewModel.recentCities?.count, count > 0 {
                switch indexPath.section {
                case 0:
                    cell.cellImage.image = UIImage(systemName: UIConstants.recentSearchImage)
                    var cellText = ""
                    if let cityName = self.viewModel.recentCities?[indexPath.row].localizedName {
                        cellText += "\(cityName)"
                    }
                    if let stateName = self.viewModel.recentCities?[indexPath.row].administrativeArea?.localizedName {
                        cellText += ", \(stateName)"
                    }
                    if let countryName = self.viewModel.recentCities?[indexPath.row].country?.localizedName {
                        cellText += ", \(countryName)"
                    }
                    cell.cityName.text = cellText
                default:
                    if indexPath.row == 0 {
                        cell.cellImage.image = UIImage(systemName: UIConstants.currentLocation)
                        cell.cityName.text = StringConstants.currentLocationText
                    } else {
                        cell.cellImage.image = UIImage(systemName: UIConstants.topCitiesImage)
                        cell.cityName.text = "City \(indexPath.row + 1)"
                    }
                }
            } else {
                if indexPath.row == 0 {
                    cell.cellImage.image = UIImage(systemName: UIConstants.currentLocation)
                    cell.cityName.text = StringConstants.currentLocationText
                } else {
                    cell.cellImage.image = UIImage(systemName: UIConstants.topCitiesImage)
                    cell.cityName.text = "City \(indexPath.row)"
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
        if let cityName = cell?.cityName.text {
            if cityName == StringConstants.currentLocationText {
                showCurrentLocationData()
            } else if let weatherInfoVC = UIStoryboard(name: UIConstants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: UIConstants.weatherInfoVC) as? WeatherInfoViewController {
                weatherInfoVC.navigationTitle = cityName
                weatherInfoVC.viewModel.currentCity = self.viewModel.searchCityResults?[indexPath.row - 1]
                weatherInfoVC.viewModel.latitude = Constants.defaultLatitude
                weatherInfoVC.viewModel.longitude = Constants.defaultLongitude
                self.navigationController?.pushViewController(weatherInfoVC, animated: true)
            } else {
                self.showAlert(title: "Error", message: "Cannot navigate")
            }
        }
    }
}

// MARK: searchBar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            self.viewModel.searchCityResults = nil
        } else {
            isSearching = true
        }
        self.searchTableView.reloadData()
    }
}
