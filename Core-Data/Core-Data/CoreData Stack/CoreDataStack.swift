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
    // For migrate data, 
    // To use this Behavior, we must sure it is DELETE JOURNAL MODE
    // Later, set up it to WAL
    // try! FileManager.default.removeItem(at: databaseURL)
        
    do {
        //let journalModeDict = ["journal_mode": "DELETE"]
        //let options = [NSSQLitePragmasOption: journalModeDict]
        try psc.addPersistentStore(ofType: NSSQLiteStoreType, 
                                   configurationName: nil, 
                                   at: databaseURL, 
                                   options: nil)
    } catch {
        print("something wrong: \(error)")
    }
    
    // Create NSManageObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
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




