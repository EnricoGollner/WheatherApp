//
//  HourlyCollectionViewCell.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 27/02/24.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: HourlyCollectionViewCell.self)
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13:00"
        label.textColor = UIColor.contrastColor
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "iconSun")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "25°C"
        label.textColor = UIColor.contrastColor
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
