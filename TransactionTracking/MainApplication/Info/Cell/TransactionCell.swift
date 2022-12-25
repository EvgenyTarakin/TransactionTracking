//
//  TransactionCell.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import UIKit

class TransactionCell: UITableViewCell {
    
//    MARK: - property
    static let reuseIdentifier = String(describing: TransactionCell.self)
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStackView, timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionCategoryLabel, amountLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var transactionCategoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
//    MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        selectionStyle = .none
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
    
//    MARK: - func
    func configurate(transaction: TransactionType, amount: String, time: String) {
        transactionCategoryLabel.text = transaction.title
        amountLabel.text = "-\(amount)"
        timeLabel.text = time
    }
    
}
