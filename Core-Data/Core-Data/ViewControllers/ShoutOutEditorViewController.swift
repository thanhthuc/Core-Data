//
//  EditorViewController.swift
//  Core-Data
//
//  Created by Thuc on 11/2/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutEditorViewController: UIViewController, ShoutOutObjectManagedContextType {

    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var toWhoPickerView: UIPickerView!
    
    @IBOutlet weak var shoutCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var fromTextField: UITextField!
    
    var pickerViewTitle = ["DDDDDD", "SSSSSS", "GGGGGG", "JJJJJJJ", "KKKKKK", "LLLLLL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        initPickerView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        print("Cancel Pressed")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        print("Save Pressed")
        dismiss(animated: true, completion: nil)
    }
    
    func initPickerView() {
        shoutCategoryPickerView.delegate = self
        shoutCategoryPickerView.dataSource = self
        toWhoPickerView.delegate = self
        toWhoPickerView.dataSource = self
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
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewTitle[row]
    }
    
}
