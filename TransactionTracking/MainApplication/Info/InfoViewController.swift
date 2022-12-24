//
//  ViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit
import SnapKit

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
        infoView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
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

