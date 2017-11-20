//
//  SaveAccessDelete.swift
//  Core-DataTests
//
//  Created by Thuc on 11/18/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import XCTest
import UIKit
import CoreData


@testable import Core_Data

class SaveAccessDelete: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testFetchAllEmployees() {
        let managedObjectContext = createMainContextInMemory()
        let dataService = DataService()
        dataService.managedObjectContext = managedObjectContext
        
        dataService.seedEmployees()
        
        let fetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
        
        do {
            let employee = try managedObjectContext.fetch(fetchRequest)
            print(employee)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testFilterShoutOuts() {
        let managedObjectContext = createMainContextInMemory()
        let dataService = DataService()
        dataService.managedObjectContext = managedObjectContext
        
        dataService.seedEmployees()
        
        seedShoutOutForTesting(managedObjectContext: managedObjectContext)
        
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        
        let shoutOutEqualityPredicate = NSPredicate(format: "%K == %@",
                                                    #keyPath(ShoutOut.shoutCategory), 
                                                    "Great Job!")
        shoutOutFetchRequest.predicate = shoutOutEqualityPredicate
        do {
            let shoutOuts = try managedObjectContext.fetch(shoutOutFetchRequest)
            print("--------First Result Set---------")
            printShoutOuts(shoutOuts: shoutOuts)
        } catch {
            print("I get an error: \(error)")
        }
        
        let shoutOutInPredicate = NSPredicate(format: "%K IN %@", #keyPath(ShoutOut.shoutCategory), "Well Done!, Great Job!")
        shoutOutFetchRequest.predicate = shoutOutInPredicate
        do {
            let shoutOuts = try managedObjectContext.fetch(shoutOutFetchRequest)
            print("--------Second Result Set---------")
            printShoutOuts(shoutOuts: shoutOuts)   
        } catch {
            print(error)
        }
        
        
        let shoutOutBEGINWITHPredicate = NSPredicate(format: "%K BEGINSWITH %@", #keyPath(ShoutOut.message), "You")
        shoutOutFetchRequest.predicate = shoutOutBEGINWITHPredicate
        do {
            let shoutOuts = try managedObjectContext.fetch(shoutOutFetchRequest)
            print("--------Third Result Set---------")
            printShoutOuts(shoutOuts: shoutOuts)
            
        } catch {
            print(error)
        }
        
        
    }
    
    func seedShoutOutForTesting(managedObjectContext: NSManagedObjectContext) {
        
        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
        do {
            let employees = try managedObjectContext.fetch(employeeFetchRequest)
            
            let shoutOut = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
            shoutOut.shoutCategory = "Great Job!"
            shoutOut.message = "Hey guy, great job on that project!"
            shoutOut.toEmployee = employees[0]
            
            let shoutOut1 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
            shoutOut1.shoutCategory = "Great Job!"
            shoutOut1.message = "Every thing are better than ever!"
            shoutOut1.toEmployee = employees[1]
            
            let shoutOut2 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
            shoutOut2.shoutCategory = "Awesome Work!"
            shoutOut2.message = "You alway do awesome work!"
            shoutOut2.toEmployee = employees[2]
            
            let shoutOut3 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
            shoutOut3.shoutCategory = "Awesome Work!"
            shoutOut3.message = "You done amazing job this year!"
            shoutOut3.toEmployee = employees[3]
            
            let shoutOut4 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
            shoutOut4.shoutCategory = "Great Job!"
            shoutOut4.message = "Hey guy, great job on that project, svsvsdvsd"
            shoutOut4.toEmployee = employees[4]
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Something wrong: \(error)")
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func printShoutOuts(shoutOuts: [ShoutOut]) {
        for shoutOut in shoutOuts {
            print("\n------ShoutOuts-------")
            print("ShoutOut Category: \(shoutOut.shoutCategory)")
            print("ShoutOut Message: \(shoutOut.message!)")
            print("To: \(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)")
        }
    }
}













