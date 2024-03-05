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
    
    private let service = Service()
    private let city = City(lat: "40.7128", long: "74.0060", name: "New York")
    private var forecastResponse: ForecastResponse?
    
    private func fetchData() {
        service.fetchData(city: city) { [weak self] response in
            self?.forecastResponse = response
            DispatchQueue.main.async {  // Changing from the background to the main thread to update UI
                self?.loadData()
            }
        }
    }
    
    private func loadData() {
        let temperature = Int(forecastResponse?.current.temp ?? 0)
        
        self.weatherView.setUpData(
            cityName: city.name,
            temperature: "\(temperature)°C",
            weatherIconName: "",
            humidity: "\(forecastResponse?.current.humidity ?? 0)mm",
            windVelocity: "\(forecastResponse?.current.windSpeed ?? 0)km/h"
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        
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
        return cell
    }
}
