//
//  WeatherViewController.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 24/02/24.
//

import UIKit

class WeatherViewController: UIViewController {
    
    lazy var weatherView: WeatherView = {
        let weatherView = WeatherView()
        return weatherView
    }()
    
    override func loadView() {
        super.loadView()
        self.view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
