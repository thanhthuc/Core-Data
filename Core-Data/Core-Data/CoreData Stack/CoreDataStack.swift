//
//  CoreDataStack.swift
//  Core-Data
//
//  Created by Thuc on 11/6/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
    
    // create NSManagedObjectModel
    let urlModel = Bundle.main.path(forResource: "ShoutOUT", ofType: ".momd")
    guard let model = NSManagedObjectModel(contentsOf: URL(string: urlModel!)!) 
        else {
            fatalError("Can not find object model")
    }
    // create NSPersistentStoreCoordinator with an NSPersitentStore 
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let databaseURL = URL.documentPath.appendingPathComponent("ShoutOUT.sqlite")
    
    do {
        let pscOptions = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        try psc.addPersistentStore(ofType: NSSQLiteStoreType, 
                                   configurationName: nil, 
                                   at: databaseURL, 
                                   options: pscOptions)
    } catch {
        print("something wrong: \(error)")
    }
    // Create NSManageObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
}

func createMainContextWithContainer(completion: @escaping (NSPersistentContainer?) -> Void) {
    
    
    let container = NSPersistentContainer(name: "ShoutOUT")
    
    let storeURL = URL.documentPath.appendingPathComponent("ShoutOUT.sqlite")
    let persistentDescriptions = NSPersistentStoreDescription(url: storeURL)
    container.persistentStoreDescriptions = [persistentDescriptions]
    
    container.loadPersistentStores { (persistanceStoreDescription, error) in
        DispatchQueue.main.async {
            completion(container)
        }
    }
}

extension URL {
    static let documentPath = try! FileManager
        .default
        .url(for: .documentDirectory, 
             in: .userDomainMask, 
             appropriateFor: nil, 
             create: true)
}

protocol ManageObjectContextDependenceType {
    var managedObjectContext: NSManagedObjectContext! { get }
}




