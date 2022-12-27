//
//  ViewController.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {
    
//    MARK: - property
    private let dataManager = DataManager()
    private let balanceService = BalanceService()
    private let coreDataManager = CoreDataManager()
    private var rightData = [TableData]()
    
    private lazy var fetchResaultController: NSFetchedResultsController<TableData> = {
        let fetchRequest: NSFetchRequest<TableData> = TableData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: false)
        let entity = NSEntityDescription.entity(forEntityName: "TableData", in: self.coreDataManager.viewContext)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchResaultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResaultController.delegate = self
        
        return fetchResaultController
    }()
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView()
        infoView.delegate = self
        
        return infoView
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .gray
        
        return separator
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 72
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        
        return indicator
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        loadBalance()
        loadTableData()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.addSubview(infoView)
        view.addSubview(indicator)
        view.addSubview(tableView)
        view.addSubview(separator)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            indicator.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            indicator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            separator.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            separator.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            separator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(setCourse(_:)), name: NSNotification.Name("courseBitcoin"), object: nil)

    }
    
    private func loadTableData() {
        do {
            try fetchResaultController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Save Note")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    private func loadBalance() {
        infoView.balance = balanceService.getBalance()
        indicator.startAnimating()
        view.alpha = 0.1
        NetworkService.getNewBitcoinCourse { [weak self] resault in
            DispatchQueue.main.async {
                self?.infoView.updateBitcoinCourse(resault)
                self?.view.alpha = 1
                self?.indicator.stopAnimating()
            }
        }
    }
    
    private func getTime() -> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY, HH:mm:ss"
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

        let tableData = TableData(context: coreDataManager.viewContext)
        tableData.amount = String(replenish)
        tableData.type = TransactionType.replenish.title
        tableData.time = getTime()
        do {
            try tableData.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print("Unable to Save Note")
            print("\(saveError), \(saveError.localizedDescription)")
        }
    }
}

extension InfoViewController: NewTransactionViewControllerDelegate {
    func addNewTransaction(amount: Int, category: TransactionType) {
        balanceService.changeBalance(amount: amount, type: category)
        infoView.updateBalance(newBalance: balanceService.getBalance())

        let tableData = TableData(context: coreDataManager.viewContext)
        tableData.amount = String(amount)
        tableData.type = category.title
        tableData.time = getTime()
        do {
            try tableData.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print("Unable to Save Note")
            print("\(saveError), \(saveError.localizedDescription)")
        }
    }
}

extension InfoViewController: UITableViewDelegate {}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResaultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResaultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.reuseIdentifier, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        configureCell(cell, at: indexPath)
        
        return cell
    }
    
    func configureCell(_ cell: TransactionCell, at indexPath: IndexPath) {
        let data = fetchResaultController.object(at: indexPath)

        cell.configurate(transaction: data.type ?? "", amount: data.amount ?? "", time: data.time ?? "")
    }
}

extension InfoViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: tableView.insertRows(at: [newIndexPath ?? IndexPath()], with: .fade)
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

