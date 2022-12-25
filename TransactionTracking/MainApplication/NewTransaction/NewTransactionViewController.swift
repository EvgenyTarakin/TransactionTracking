//
//  NewTransactionViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

// MARK: - protocol
protocol NewTransactionViewControllerDelegate: AnyObject {
    func addNewTransaction(amount: Int, category: TransactionType)
}

class NewTransactionViewController: UIViewController {
    
//    MARK: - property
    weak var delegate: NewTransactionViewControllerDelegate?
    
    private lazy var newTransactionView: NewTransactionView = {
        let newTransactionView = NewTransactionView()
        newTransactionView.delegate = self
        
        return newTransactionView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.backgroundColor = .black
        
        view.addSubview(newTransactionView)
        newTransactionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newTransactionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newTransactionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newTransactionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newTransactionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

}

extension NewTransactionViewController: NewTransactionViewDelegate {
    func tapedOnView() {
        view.endEditing(true)
    }
    
    func didSelectCategoryButton() {
        present(newTransactionView.alert, animated: true, completion: nil)
    }
    
    func didSelectTransactionButton(amount: String, category: String) {
        let amountInt = Int(amount) ?? 0
        var typeTransaction: TransactionType = .other
        switch category {
        case "Groceries": typeTransaction = .groceries
        case "Taxi": typeTransaction = .taxi
        case "Electronic": typeTransaction = .electronic
        case "Restaurant": typeTransaction = .restaurant
        default: typeTransaction = .other
        }
        delegate?.addNewTransaction(amount: amountInt, category: typeTransaction)
        navigationController?.popViewController(animated: true)
    }
}
