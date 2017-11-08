//
//  ViewController.swift
//  Core-Data
//
//  Created by Thuc on 10/28/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit
import CoreData

class ShoutOutDraftsViewController: UIViewController, ShoutOutObjectManagedContextType {
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        
        switch segue.identifier! {
        case "detail":
            let destVC = segue.destination as! ShoutOutDetailViewController
            destVC.managedObjectContext = managedObjectContext
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

extension ShoutOutDraftsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self)
    }
}

extension ShoutOutDraftsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DraftTableViewCell
        cell.titleLabel.text = "first title"
        cell.subtitleLabel.text = "first subtitle"
        return cell
    }
}


