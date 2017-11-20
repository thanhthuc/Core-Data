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
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    let databaseURL = documentPath?.appendingPathComponent("ShoutOUT.sqlite")
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: databaseURL!, options: nil)
    
    // Create NSManageObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}

protocol ManageObjectContextDependenceType {
    var managedObjectContext: NSManagedObjectContext! { get }
}




