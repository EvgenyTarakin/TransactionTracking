//
//  DataManager.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 26.12.2022.
//

import Foundation
import CoreData

class DataManager: Hashable {
    
    private let context = CoreDataManager().persistentContainer.viewContext

    var tableDatas: [TableData] {
        let fetchRequest: NSFetchRequest<TableData> = TableData.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    var balance: [Balance] {
        let fetchRequest: NSFetchRequest<Balance> = Balance.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveData(type: String, amount: String, time: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "TableData", in: context) else {
            return
        }
        
        let history = TableData(entity: entity, insertInto: context)
        history.type = type
        history.amount = amount
        history.time = time
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func saveBalance(amount: Double) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance", in: context) else {
            return
        }
        let balance = Balance(entity: entity, insertInto: context)
        balance.amount = amount
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    let uuid = UUID()
    static func ==(lhs: DataManager, rhs: DataManager) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}
