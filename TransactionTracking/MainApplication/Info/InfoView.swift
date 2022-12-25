//
//  InfoView.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

// MARK: - protocol
protocol InfoViewDelegate: AnyObject {
    func didSelectAddTransactionButton()
    func didSelectReplenishButton()
}

class InfoView: UIView {
    
//    MARK: - property
    weak var delegate: InfoViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setAppTitleLabel("Transaction tracking")
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [courseLabel, balanceStackView, addTransactionButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        stackView.spacing = 16
        
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            courseLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        return stackView
    }()
    
    private lazy var courseLabel: UILabel = {
        let label = UILabel()
        label.setAppLabel()
        
        return label
    }()
    
    private lazy var balanceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [replenishButton, balanceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16

        replenishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            replenishButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        return stackView
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.setAppLabel()
        
        return label
    }()
    
    private lazy var replenishButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(.init(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(tapReplenishButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let button = UIButton()
        button.setAppButton("Add transaction")
        button.addTarget(self, action: #selector(tapAddTransactionButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
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
        setAppView()
        
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    MARK: - obj-c
    @objc private func tapAddTransactionButton() {
        delegate?.didSelectAddTransactionButton()
    }
    
    @objc private func tapReplenishButton() {
        delegate?.didSelectReplenishButton()
    }
    
//    MARK: - func
    func configurate(balance: Int = 0, course: Int = 0) {
        balanceLabel.text = "Balance: \(balance)"
        courseLabel.text = "Bitcoin rate: \(course)"
    }
    
}
