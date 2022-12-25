//
//  UIButtonExtension.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import UIKit

extension UIButton {
    func setAppButton(_ text: String) {
        self.setTitleColor(.systemBlue, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 24)
        self.setTitle(text, for: .normal)
    }
}
