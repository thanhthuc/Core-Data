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
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<ShoutOut>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTableView()
        
        configureFetchedResultController()
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureFetchedResultController() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        let lastNameSortDescriptor = NSSortDescriptor(
            key: #keyPath(ShoutOut.toEmployee.lastName), 
            ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(
            key: #keyPath(ShoutOut.toEmployee.firstName), 
            ascending: true)
        shoutOutFetchRequest.sortDescriptors = [
            lastNameSortDescriptor, 
            firstNameSortDescriptor
        ]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: shoutOutFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        //tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)        
        switch segue.identifier! {
        case "detail":
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let destVC = segue.destination as! ShoutOutDetailViewController
            destVC.managedObjectContext = managedObjectContext
            destVC.shoutOut = fetchedResultsController.object(at: indexPath!)
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
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DraftTableViewCell
        let shoutOut = fetchedResultsController.object(at: indexPath)
        cell.titleLabel.text = shoutOut.shoutCategory
        cell.subtitleLabel.text = shoutOut.toEmployee.lastName
        return cell
    }
}

extension ShoutOutDraftsViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, 
                    didChange anObject: Any, 
                    at indexPath: IndexPath?, 
                    for type: NSFetchedResultsChangeType, 
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let deletedIndexPath = indexPath {
                tableView.deleteRows(at: [deletedIndexPath], with: .fade)
            }
        case .insert:
            if let insertedIndexPath = newIndexPath {
                tableView.insertRows(at: [insertedIndexPath], with: .fade)
            }
        case .move:
            if let deletedIndexPath = indexPath {
                tableView.deleteRows(at: [deletedIndexPath], with: .fade)
            }
            if let insertedIndexPath = newIndexPath {
                tableView.insertRows(at: [insertedIndexPath], with: .fade)
            }            
        case .update:
            if let updatedIndexPath = indexPath {
                let cell = tableView.cellForRow(at: updatedIndexPath) as! DraftTableViewCell
            	let shoutOut = fetchedResultsController.object(at: updatedIndexPath)
                cell.titleLabel.text = shoutOut.shoutCategory
                cell.subtitleLabel.text = shoutOut.toEmployee.lastName
            }
        }
    }
    
}















