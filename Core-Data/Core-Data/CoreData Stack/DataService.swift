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
            let employees = try managedObjectContext.fetch(fetchedRequest)
            let seededEmplyee = employees.count > 0
            
            if seededEmplyee == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                
                employee1.firstName = "Nguyen"
                employee1.lastName = "Thanh Thuc"
                employee1.department = "New Imformation technology"
                
                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee2.firstName = "Tran"
                employee2.lastName = "Duy Tien"
                employee2.department = "New Imformation technology"
                
                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee3.firstName = "Ngo"
                employee3.lastName = "Hoang Phuong"
                employee3.department = "New Polytical"
                
                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee4.firstName = "Nguyen"
                employee4.lastName = "Van Bao Chinh"
                employee4.department = "New Imformation technology"
                
                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee5.firstName = "Nguyen"
                employee5.lastName = "Thi Nhu Quynh"
                employee5.department = "New Accountant"
                
                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: managedObjectContext) as! Employee
                employee6.firstName = "Tran"
                employee6.lastName = "Van Giang"
                employee6.department = "New Networking"
                                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Something wrong with your data, let see reason")
                    print(error)
                    managedObjectContext.rollback()
                }
            } else {
                for employee in employees {
                    switch employee.lastName {
                    case "Thanh Thuc":
                        employee.department = "Information technology"
                    case "Duy Tien":
                        employee.department = "Information technology"
                    case "Hoang Phuong":
                        employee.department = "Polytical"
                    case "Van Bao Chinh":
                        employee.department = "Information technology"
                    case "Thi Nhu Quynh":
                        employee.department = "Accountant"
                    case "Van Giang":
                        employee.department = "Networking"
                    default:
                        print("Nothing to insert")
                    }
                }
                do {
                    try managedObjectContext.save()
                } catch {
                    managedObjectContext.rollback()
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}
