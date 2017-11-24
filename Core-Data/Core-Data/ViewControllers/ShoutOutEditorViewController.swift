//
//  EditorViewController.swift
//  Core-Data
//
//  Created by Thuc on 11/2/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutEditorViewController: UIViewController, ManageObjectContextDependenceType {

    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var toWhoPickerView: UIPickerView!
    
    @IBOutlet weak var shoutCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var fromTextField: UITextField!
    
    var shoutCategorys = [
        "Great Job!", 
        "Awesome Work!", 
        "Well Done!", 
        "Amazing Effort!"
    ]
    
    var employee:[Employee] = []
    
    var shoutOutMO: ShoutOut!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        shoutOutMO = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: managedObjectContext) as! ShoutOut
        
        initPickerView()
        fetchEmployee()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        print("Cancel Pressed")
        managedObjectContext.rollback()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let toEmPloyeeIndex = toWhoPickerView.selectedRow(inComponent: 0)
        let toEmployee = employee[toEmPloyeeIndex]
        let shoutOutCategoryIndex = shoutCategoryPickerView.selectedRow(inComponent: 0)
        let shoutCategory = shoutCategorys[shoutOutCategoryIndex]
        
        shoutOutMO.toEmployee = toEmployee
        shoutOutMO.shoutCategory = shoutCategory
        shoutOutMO.from = fromTextField.text
        shoutOutMO.message = messageTextView.text
        shoutOutMO.sentOn = Date()
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func initPickerView() {
        shoutCategoryPickerView.delegate = self
        shoutCategoryPickerView.dataSource = self
        toWhoPickerView.delegate = self
        toWhoPickerView.dataSource = self
    }
    
    func fetchEmployee() {
        let fetchEmployeeRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
        
        let employeeSort = NSSortDescriptor(key: #keyPath(Employee.firstName), ascending: true)
        let secondSort = NSSortDescriptor(key: #keyPath(Employee.lastName), ascending: true)
        fetchEmployeeRequest.sortDescriptors = [employeeSort,secondSort]
        
        do {
            employee = try managedObjectContext.fetch(fetchEmployeeRequest)
        } catch {
            employee = []
            print("Something went wrong: \(error.localizedDescription)")
        }
        
    }
    
    @objc func dismisKeyBoard() {
        messageTextView.endEditing(true)
        fromTextField.endEditing(true)
    }
}


extension ShoutOutEditorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

extension ShoutOutEditorViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == toWhoPickerView {
            return employee.count
        } else {
            return shoutCategorys.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == toWhoPickerView {
            let name = "\(employee[row].firstName) \(employee[row].lastName)"
            return name
        } else {
            return shoutCategorys[row]
        }
    }
    
}
