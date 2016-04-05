//
//  ViewController.swift
//  Retrobox
//
//  Created by Pivotal on 4/5/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit

class RetroListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    var messages: Array<String> = []
    
    var happyList = ["New chairs!", "Ping pong! 🏓"]
    var mediocreList = ["New chairs squeak.", "Only one ping pong table."]
    var unhappyList = ["New chairs broken.", "Ping pong table broken."]
    var currentList: Array<String> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentList = happyList
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        titleLabel.text = "🙂"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "CELL")
        cell.textLabel?.text = currentList[indexPath.row]
        return cell
    }
    
    @IBAction func happyButtonTapped(sender: UIButton) {
        titleLabel.text = "🙂"
        currentList = happyList
        tableView.reloadData()
    }
    
    @IBAction func mehButtonTapped(sender: UIButton) {
        titleLabel.text = "😐"
        currentList = mediocreList
        tableView.reloadData()
    }

    @IBAction func unhappyButtonTapped(sender: UIButton) {
        titleLabel.text = "☹️"
        currentList = unhappyList
        tableView.reloadData()
    }

}

