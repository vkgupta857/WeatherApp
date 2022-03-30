//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

class WeatherInfoViewController: UIViewController {

    lazy var viewModel: WeatherInfoVM = {
        return WeatherInfoVM()
    }()
    
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        setupUI()
    }
    
    func initVM() {
        
    }
    
    func setupUI() {
        self.navigationItem.title = navigationTitle
        debugPrint(viewModel.latitude as Any, viewModel.longitude as Any)
    }
}
