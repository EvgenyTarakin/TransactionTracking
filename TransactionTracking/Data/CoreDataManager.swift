//
//  CoreDataManager.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 26.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(error):\(error.userInfo)")
            }
        })
        return container
    }()

    lazy var viewContext: NSManagedObjectContext = {
        return CoreDataManager.persistentContainer.viewContext
    }()

    func saveContext() {
        let context = CoreDataManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("\(nserror):\(nserror.userInfo)")
            }
        }
    }

}
