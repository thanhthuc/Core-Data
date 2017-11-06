//
//  CoreDataStack.swift
//  Core-Data
//
//  Created by Thuc on 11/6/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() {
    
    // create NSManagedObjectModel
    let urlModel = Bundle.main.path(forResource: "ShoutOUT", ofType: ".momd")
    guard let model = NSManagedObjectModel(contentsOf: URL(string: urlModel!)!) 
        else {
        fatalError("Can not find object model")
    }
    
    // create NSPersistentStoreCoordinator with an NSPersitentStore 
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let databaseURL = Bundle.main.path(forResource: "ShoutOUT", ofType: "sqlite")
    psc.addPersistentStore(ofType: "", configurationName: nil, at: URL(string: databaseURL), options: nil)
    
    // Create NSManageObjectContext
    
    
}


