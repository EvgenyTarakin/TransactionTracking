//
//  ReplenishViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import UIKit

class ReplenishViewController: UIViewController {
    
//    MARK: - property
    private lazy var replenishView: ReplenishView = {
        let replenishView = ReplenishView()
        replenishView.delegate = self
        
        return replenishView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {        
        view.addSubview(replenishView)
        replenishView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            replenishView.topAnchor.constraint(equalTo: view.topAnchor),
            replenishView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            replenishView.leftAnchor.constraint(equalTo: view.leftAnchor),
            replenishView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}

extension ReplenishViewController: ReplenishViewDelegate {
    func didTapedOnView() {
        view.endEditing(true)
    }
    
    func didSelectCloseButton() {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    func didSelectReplenishButton() {
        view.endEditing(true)
        dismiss(animated: true)
    }
}
