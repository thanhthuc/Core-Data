//
//  DataService.swift
//  Core-Data
//
//  Created by Thuc on 11/18/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManageObjectContextDependenceType {
    
    var managedObjectContext: NSManagedObjectContext!
    
    func seedEmployees() {
        
        let fetchedRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
        do {
            let seededEmplyee = try managedObjectContext.fetch(fetchedRequest).count > 0
            if seededEmplyee == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                
                employee1.firstName = "Nguyen"
                employee1.lastName = "Thanh Thuc"
                
                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee2.firstName = "Tran"
                employee2.lastName = "Duy Tien"
                
                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee3.firstName = "Ngo"
                employee3.lastName = "Hoang Phuong"
                
                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee4.firstName = "Nguyen"
                employee4.lastName = "Van Bao Chinh"
                
                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee5.firstName = "Nguyen"
                employee5.lastName = "Thi Nhu Quynh"
                
                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee6.firstName = "Tran"
                employee6.lastName = "Van Giang"
                                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Something wrong with your data, let see reason")
                    print(error)
                    managedObjectContext.rollback()
                }
            }
        } catch {
            print(error)
        }
    }
}
