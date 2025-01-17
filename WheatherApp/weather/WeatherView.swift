//
//  WeatherView.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 27/02/24.
//

import UIKit

class WeatherView: UIView {
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.primaryColor
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.textColor = UIColor.primaryColor
        
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sunIcon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 12,
            leading: 20,
            bottom: 12,
            trailing: 20
        )
        stackView.backgroundColor = UIColor.softGrayColor
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umidade"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vento"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PREVISÃO POR HORA"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    public func configCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        hourlyCollectionView.delegate = delegate
        hourlyCollectionView.dataSource = dataSource
    }
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRÓXIMOS DIAS"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.contrastColor
        
        return label
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        
        return tableView
    }()
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.dailyForecastTableView.delegate = delegate
        self.dailyForecastTableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpData(cityName: String, temperature: String?, weatherIconName: String, humidity: String, windVelocity: String, backgroundIconName: String?) {
        cityLabel.text = cityName
        temperatureLabel.text = temperature
        humidityValueLabel.text = humidity
        windValueLabel.text = windVelocity
        
        hourlyCollectionView.reloadData()
        dailyForecastTableView.reloadData()
        
        
        backgroundView.image = UIImage(named: backgroundIconName ?? "")
    }
    
    private func setUpView() {
        self.setHierarchy()
        self.setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(backgroundView)
        
        addSubview(headerView)
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
        
        addSubview(statsStackView)
        
        addSubview(hourlyForecastLabel)
        addSubview(hourlyCollectionView)
        
        addSubview(dailyForecastLabel)
        addSubview(dailyForecastTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 71),
            
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 8),
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 210),
            statsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 29),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 29),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 16),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
