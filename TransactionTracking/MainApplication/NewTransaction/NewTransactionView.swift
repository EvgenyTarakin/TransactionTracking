//
//  NewTransactionView.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

// MARK: - protocol
protocol NewTransactionViewDelegate: AnyObject {
    func tapedOnView()
    func didSelectCategoryButton()
    func didSelectTransactionButton(amount: String, category: String)
}

class NewTransactionView: UIView {

//    MARK: - property
    weak var delegate: NewTransactionViewDelegate?
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Select category", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Groceries", style: .default, handler: chooseCategory))
        alert.addAction(UIAlertAction(title: "Taxi", style: .default, handler: chooseCategory))
        alert.addAction(UIAlertAction(title: "Electronic", style: .default, handler: chooseCategory))
        alert.addAction(UIAlertAction(title: "Restaurant", style: .default, handler: chooseCategory))
        alert.addAction(UIAlertAction(title: "Other", style: .default, handler: chooseCategory))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        
        return alert
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setAppTitleLabel("New transaction")
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setAppTextField("Enter the amount to transfer")
        
        return textField
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Select category", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(tapCategoryButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var transactionButton: UIButton = {
        let button = UIButton()
        button.setAppButton("Add transaction")
        button.addTarget(self, action: #selector(tapTransactionButton), for: .touchUpInside)
        
        return button
    }()
    
//    MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

//    MARK: - private func
    private func commonInit() {
        addGestureRecognizer(tap)
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(categoryButton)
        addSubview(transactionButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        transactionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 54),
            
            categoryButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            categoryButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            categoryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            categoryButton.heightAnchor.constraint(equalToConstant: 50),
            
            transactionButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 16),
            transactionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            transactionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            transactionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func chooseCategory(_ handler: UIAlertAction) {
        categoryButton.setTitleColor(.white, for: .normal)
        categoryButton.setTitle(handler.title, for: .normal)
    }
    
//    MARK: - obj-c
    @objc private func tapOnView() {
        delegate?.tapedOnView()
    }
    
    @objc private func tapCategoryButton() {
        delegate?.didSelectCategoryButton()
    }
    
    @objc private func tapTransactionButton() {
        if textField.text != "" && textField.text != nil {
            delegate?.didSelectTransactionButton(amount: textField.text ?? "", category: categoryButton.titleLabel?.text ?? "")
        }
    }

}

extension NewTransactionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "0" && (textField.text == "" || textField.text == nil) {
            return false
        }
        return true
    }
}
