//
//  UITextFieldExtension.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import UIKit

extension UITextField {
    func setAppTextField(_ placeholder: String) {
        self.textAlignment = .center
        self.keyboardType = .numberPad
        self.backgroundColor = .lightGray
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.font = .systemFont(ofSize: 24)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}

