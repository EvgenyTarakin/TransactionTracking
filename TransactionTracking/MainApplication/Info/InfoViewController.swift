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
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectReplenishButton() {
        let controller = ReplenishViewController()
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 32
            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(controller, animated: true)
    }
}

