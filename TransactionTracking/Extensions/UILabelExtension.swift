//
//  UILabelExtension.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

extension UILabel {
    func setAppLabel() {
        self.textAlignment = .right
        self.textColor = .white
        self.font = .systemFont(ofSize: 24)
    }
    
    func setAppTitleLabel(_ text: String) {
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 32)
        self.text = text
    }
}
