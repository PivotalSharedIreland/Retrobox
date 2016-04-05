//
//  ViewController.swift
//  Retrobox
//
//  Created by Pivotal on 4/5/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RetroListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    var happyList: Array<String> = []
    var mediocreList: Array<String> = []
    var unhappyList: Array<String> = []
    var currentList: RetroItemType = .Happy
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getBoardItems()
        
        tableView.reloadData()
    }
    
    func getBoardItems() {
        Alamofire.request(.GET, "http://private-5f175-antra.apiary-mock.com/boards/1/items", parameters: [:])
            .responseJSON { response in
                
                self.happyList = []
                self.mediocreList = []
                self.unhappyList = []
                
                if let result = response.result.value {
                    
                    let json = JSON(result)
                    
                    for retroItemJson in json["items"].array! {
                        let retroItem = RetroItem(json: retroItemJson)
                        switch retroItem.type {
                        case .Happy:
                            self.happyList.append(retroItem.message)
                        case .Mediocre:
                            self.mediocreList.append(retroItem.message)
                        case .Unhappy:
                            self.unhappyList.append(retroItem.message)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        titleLabel.text = "🙂"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentList {
        case .Happy:
            return happyList.count
        case .Mediocre:
            return mediocreList.count
        case .Unhappy:
            return unhappyList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "CELL")
        
        switch currentList {
        case .Happy:
            cell.textLabel?.text = happyList[indexPath.row]
        case .Mediocre:
            cell.textLabel?.text = mediocreList[indexPath.row]
        case .Unhappy:
            cell.textLabel?.text = unhappyList[indexPath.row]
        }
        
        return cell
    }
    
    @IBAction func happyButtonTapped(sender: UIButton) {
        titleLabel.text = "🙂"
        currentList = .Happy
        tableView.reloadData()
    }
    
    @IBAction func mehButtonTapped(sender: UIButton) {
        titleLabel.text = "😐"
        currentList = .Mediocre
        tableView.reloadData()
    }

    @IBAction func unhappyButtonTapped(sender: UIButton) {
        titleLabel.text = "☹️"
        currentList = .Unhappy
        tableView.reloadData()
    }

}

