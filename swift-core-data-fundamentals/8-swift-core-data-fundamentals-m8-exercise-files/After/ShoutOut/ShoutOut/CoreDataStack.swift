//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 10/30/16.
//  Copyright © 2016 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext(completion: @escaping (NSPersistentContainer) -> Void) {
	
	let container = NSPersistentContainer(name: "ShoutOut")
	
	let storeURL = URL.documentsURL.appendingPathComponent("ShoutOut.sqlite")
	let storeDescription = NSPersistentStoreDescription(url: storeURL)
	container.persistentStoreDescriptions = [storeDescription]
	
	// Happens asynchronously!
	container.loadPersistentStores(completionHandler: {
		persistentStoreDescription, error in
		
		guard error == nil else { fatalError("Failed to load store: \(error)") }
		
		DispatchQueue.main.async {
			completion(container)
		}
	})
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




