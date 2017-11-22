//
//  ShoutOutDetailViewController.swift
//  Core-Data
//
//  Created by Thuc on 11/2/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutDetailViewController: UIViewController, ManageObjectContextDependenceType {

    var managedObjectContext: NSManagedObjectContext!
    var shoutOut: ShoutOut?
    
    @IBOutlet weak var categoryTextField: UILabel!
    
    @IBOutlet weak var messageTextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryTextField.text = shoutOut!.shoutCategory
        messageTextview.text = shoutOut!.message
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    @IBAction func didTapEditButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "", message: "Do you want to delete", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.managedObjectContext.delete(self.shoutOut!)
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! UINavigationController
        let shoutOutEditorVC = dest.viewControllers.first as! ShoutOutEditorViewController
        shoutOutEditorVC.managedObjectContext = managedObjectContext
    }
    

}
