//
//  ViewController.swift
//  Core-Data
//
//  Created by Thuc on 10/28/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutDraftsViewController: UIViewController, ManageObjectContextDependenceType {
    
    var managedObjectContext: NSManagedObjectContext!
    var shoutOuts: [ShoutOut] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        
        do {
            shoutOuts = try managedObjectContext.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        //tableView.delegate = self
        tableView.dataSource = self
        let request = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        
        do {
            shoutOuts = try managedObjectContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)        
        switch segue.identifier! {
        case "detail":
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let destVC = segue.destination as! ShoutOutDetailViewController
            destVC.managedObjectContext = managedObjectContext
            destVC.shoutOut = shoutOuts[indexPath!.row]
        default:
            let destVC = segue.destination as! UINavigationController
            let shoutOutVC = destVC.viewControllers.first as! ShoutOutEditorViewController
            shoutOutVC.managedObjectContext = managedObjectContext
        }
    }
    
    @IBAction func didTapAddNew(_ sender: Any) {
        performSegue(withIdentifier: "addNew", sender: self)
    }
}

extension ShoutOutDraftsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoutOuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DraftTableViewCell
        cell.titleLabel.text = shoutOuts[indexPath.row].shoutCategory
        cell.subtitleLabel.text = shoutOuts[indexPath.row].toEmployee.lastName
        return cell
    }
}


