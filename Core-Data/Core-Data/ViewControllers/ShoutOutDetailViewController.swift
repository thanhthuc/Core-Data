//
//  ShoutOutDetailViewController.swift
//  Core-Data
//
//  Created by Thuc on 11/2/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutDetailViewController: UIViewController, ShoutOutObjectManagedContextType {

    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
    @IBAction func didTapEditButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
