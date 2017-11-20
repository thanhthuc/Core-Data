
//
//  ShoutOutTest.swift
//  Core-DataTests
//
//  Created by Thuc on 11/19/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import XCTest
import CoreData
import UIKit

@testable import Core_Data

class ShoutOutTest: XCTestCase {
    
    var systemUnderTestVC: ShoutOutDraftsViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationViewController = storyBoard.instantiateInitialViewController() as! UINavigationController
        systemUnderTestVC = navigationViewController.viewControllers[0] as! ShoutOutDraftsViewController
        UIApplication.shared.keyWindow?.rootViewController = systemUnderTestVC
        navigationViewController.preloadView()
        systemUnderTestVC.preloadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateContextInMemory() {
        let context = createMainContextInMemory()
        systemUnderTestVC.managedObjectContext = context
        
//        XCTAssert(systemUnderTestVC.managedObjectContext != nil)
        XCTAssertNotNil(systemUnderTestVC.managedObjectContext)
    }
}

func createMainContextInMemory() -> NSManagedObjectContext {
    let modelURL = Bundle.main.url(forResource: "ShoutOUT", withExtension: "momd")
    let model = NSManagedObjectModel(contentsOf: modelURL!)
    
    guard let modelUnWapped = model else {
        fatalError("No such file for Model")
    }
    
    let persistentStoreCoordinate = NSPersistentStoreCoordinator(managedObjectModel: modelUnWapped)
    do {
        try persistentStoreCoordinate.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)  
    } catch {
        print(error.localizedDescription)
    }
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = persistentStoreCoordinate
    
    return context
}

extension UIViewController {
    func preloadView() {
        _ = view
    }
}
