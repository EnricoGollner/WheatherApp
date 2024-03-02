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
        weatherView.configCollectionView(delegate: self, dataSource: self)
        weatherView.configTableView(delegate: self, dataSource: self)
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
