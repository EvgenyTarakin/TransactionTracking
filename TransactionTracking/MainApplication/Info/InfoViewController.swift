//
//  ViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
//    MARK: - property
    private let dataManager = DataManager()
    private let balanceService = BalanceService()
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView()
        infoView.delegate = self
        
        return infoView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        
        return indicator
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        infoView.transactionData = dataManager.tableDatas.reversed()
        infoView.balance = balanceService.getBalance()
        
        indicator.startAnimating()
        infoView.alpha = 0.1
        NetworkService.getNewBitcoinCourse { [weak self] resault in
            DispatchQueue.main.async {
                self?.infoView.updateBitcoinCourse(resault)
                self?.infoView.alpha = 1
                self?.indicator.stopAnimating()
            }
        }
    }
    
//    MARK: - private func
    private func commonInit() {
        view.addSubview(infoView)
        view.addSubview(indicator)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            indicator.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            indicator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(setCourse(_:)), name: NSNotification.Name("courseBitcoin"), object: nil)

    }
    
    private func getTime() -> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY, HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let time = formatter.string(from: date as Date)
        
        return time
    }
    
//    MARK: - obj-c
    @objc private func setCourse(_ notification: NSNotification) {
        infoView.updateBitcoinCourse(notification.userInfo?["courseBitcoin"] as? String ?? "")
    }

}

// MARK: - extension
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
        balanceService.changeBalance(amount: replenish, type: .replenish)
        infoView.updateBalance(newBalance: balanceService.getBalance())

        dataManager.saveData(type: TransactionType.replenish.title, amount: String(replenish), time: getTime())
        infoView.transactionData = dataManager.tableDatas.reversed()
        infoView.updateData()
    }
}

extension InfoViewController: NewTransactionViewControllerDelegate {
    func addNewTransaction(amount: Int, category: TransactionType) {
        balanceService.changeBalance(amount: amount, type: category)
        infoView.updateBalance(newBalance: balanceService.getBalance())

        dataManager.saveData(type: category.title, amount: String(amount), time: getTime())
        infoView.transactionData = dataManager.tableDatas.reversed()
        infoView.updateData()
    }
}

