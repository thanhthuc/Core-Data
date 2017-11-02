//
//  ViewController.swift
//  Core-Data
//
//  Created by Thuc on 10/28/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit

class ShoutOutDraftsViewController: UIViewController {
    
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
}

extension ShoutOutDraftsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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


