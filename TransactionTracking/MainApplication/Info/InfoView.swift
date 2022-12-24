//
//  InfoView.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit
import SnapKit

// MARK: - protocol
protocol InfoViewDelegate: AnyObject {
    func didSelectAddTransactionButton()
    func didSelectReplenishButton()
}

class InfoView: UIView {
    
//    MARK: - property
    weak var delegate: InfoViewDelegate?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [courseLabel, balanceStackView, addTransactionButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        stackView.spacing = 16
        
        courseLabel.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
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
        
        replenishButton.snp.makeConstraints {
            $0.width.equalTo(36)
        }
        
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
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitle("Add transaction", for: .normal)
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
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-16)
            $0.bottom.left.right.equalToSuperview()
        }
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
