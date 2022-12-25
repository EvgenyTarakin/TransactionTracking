//
//  NewTransactionViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
//    MARK: - property
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
        
    }
    
    func didSelectTransactionButton() {
        
    }
}
