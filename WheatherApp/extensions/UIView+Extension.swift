//
//  UIView+Extension.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 02/03/24.
//

import UIKit

extension UIView {
    ///Set constraints to parent view
    public func pin(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
