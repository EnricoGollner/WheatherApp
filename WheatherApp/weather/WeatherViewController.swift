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
        service.fetchData(city: city) { [weak self] forecastResponse in
            self?.forecastResponse = forecastResponse
            DispatchQueue.main.async {
                self?.loadData()
            }
        }
    }
    
    private func loadData() {
        self.weatherView.setUpData(
            cityName: city.name,
            temperature: forecastResponse?.current.temp.toCelsius(),
            weatherIconName: "",
            humidity: "\(forecastResponse?.current.humidity ?? 0)mm",
            windVelocity: "\(forecastResponse?.current.windSpeed ?? 0)km/h",
            backgroundIconName: forecastResponse?.current.dt.isDayTime() ?? true ? "background-day" : "background-night"
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
        return forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let forecast = forecastResponse?.hourly[indexPath.row]
        cell.setUpData(
            time: forecast?.dt.toHourFormat(),
            iconImageName: forecast?.weather.first?.icon,
            temperature: forecast?.temp.toCelsius()
        )
        
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let forecast = forecastResponse?.daily[indexPath.row]
        cell.setUpData(
            weekDay: forecast?.dt.toWeekdayName().uppercased(),
            min: forecast?.temp.min.toCelsius(),
            max: forecast?.temp.max.toCelsius(),
            iconName: forecast?.weather.first?.icon
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
