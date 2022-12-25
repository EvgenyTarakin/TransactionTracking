//
//  ViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
//    MARK: - property
    private lazy var infoView: InfoView = {
        let infoView = InfoView()
        infoView.delegate = self
        infoView.configurate()
        
        return infoView
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

}

extension InfoViewController: InfoViewDelegate {
    func didSelectAddTransactionButton() {
        let controller = NewTransactionViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectReplenishButton() {
        let controller = ReplenishViewController()
        controller.delegate = self
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 32
            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(controller, animated: true)
    }
}

extension InfoViewController: ReplenishViewControllerDelegate {
    func setNewValueBalance(_ replenish: Int) {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY, HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let time = formatter.string(from: date as Date)
        
        let newBalance = (infoView.balance ?? 0) + replenish
        infoView.updateBalance(newBalance: newBalance)
        infoView.updateData(Transaction(type: .replenish, amount: String(replenish), time: time))
    }
}

extension InfoViewController: NewTransactionViewControllerDelegate {
    func addNewTransaction(amount: Int, category: TransactionType) {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY, HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let time = formatter.string(from: date as Date)
        
        let newBalance = (infoView.balance ?? 0) - amount
        infoView.updateBalance(newBalance: newBalance)
        infoView.updateData(Transaction(type: category, amount: String(amount), time: time))
    }
}

