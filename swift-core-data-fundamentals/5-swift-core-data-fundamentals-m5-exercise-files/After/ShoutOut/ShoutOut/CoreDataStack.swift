//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 10/30/16.
//  Copyright © 2016 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
	
	// Initialize NSManagedObjectModel
	let modelURL = Bundle.main.url(forResource: "ShoutOut", withExtension: "momd")
	guard let model = NSManagedObjectModel(contentsOf: modelURL!) else { fatalError("model not found") }
	
	// Configure NSPersistentStoreCoordinator with an NSPersistentStore
	let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
	let storeURL = URL.documentsURL.appendingPathComponent("ShoutOut.sqlite")
	
	// TODO: Use migrations!
	try! FileManager.default.removeItem(at: storeURL)
	
	try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
	
	// Create and return NSManagedObjectContext
	let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
	context.persistentStoreCoordinator = psc
	
	return context
}

extension URL {
	static var documentsURL: URL {
		return try! FileManager
			.default
			.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
	}
}

protocol ManagedObjectContextDependentType {
	var managedObjectContext: NSManagedObjectContext! { get set}
}




