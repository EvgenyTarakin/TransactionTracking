//
//  ReplenishView.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import UIKit

// MARK: - protocol
protocol ReplenishViewDelegate: AnyObject {
    func didTapedOnView()
    func didSelectCloseButton()
    func didSelectReplenishButton(_ replenish: String)
}

class ReplenishView: UIView {
    
//    MARK: - property
    weak var delegate: ReplenishViewDelegate?
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setAppTitleLabel("Balance replenishment")
        
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setAppTextField("Enter amount")
        
        return textField
    }()
    
    private lazy var replenishButton: UIButton = {
        let button = UIButton()
        button.setAppButton("Replenish")
        button.addTarget(self, action: #selector(tapReplenishButton), for: .touchUpInside)
        
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
        backgroundColor = .darkGray
        
        addGestureRecognizer(tap)
        addSubview(titleLabel)
        addSubview(closeButton)
        addSubview(textField)
        addSubview(replenishButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        replenishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            textField.heightAnchor.constraint(equalToConstant: 54),
            
            replenishButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            replenishButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            replenishButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            replenishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    MARK: - objc
    @objc private func tapOnView() {
        delegate?.didTapedOnView()
    }
    
    @objc private func tapCloseButton() {
        delegate?.didSelectCloseButton()
    }
    
    @objc private func tapReplenishButton() {
        if textField.text != "" && textField.text != nil && textField.text != "0" {
            delegate?.didSelectReplenishButton(textField.text ?? "0")
        }
    }
    
}
