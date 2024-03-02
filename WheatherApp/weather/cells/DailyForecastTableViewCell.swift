//
//  TemperatureTableViewCell.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 02/03/24.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: DailyForecastTableViewCell.self)
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        
    }
    
    private func setHierarchy() {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
