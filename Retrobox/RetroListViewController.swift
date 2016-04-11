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
//import "NSMutableArray+SWUtilityButtons.h"

class RetroListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddFeedbackViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    var happyList: Array<RetroItem> = []
    var mediocreList: Array<RetroItem> = []
    var unhappyList: Array<RetroItem> = []
    var currentList: RetroItemType = .Happy
    var addFeedbackView: UIView?
    var keyboardOffset: CGFloat = 0.0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        tableView.backgroundColor = UIColor.clearColor()
        getBoardItems()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RetroListViewController.keyboardWasShown(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RetroListViewController.keyboardWasHidden(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
        tableView.reloadData()
    }
    
    func postWasSuccessful() {
        getBoardItems()
    }
    
    func getBoardItems() {
        
        let url = "http://retrobox-api.cfapps.io/board/1" //api
//        let url = "http://private-5f175-antra.apiary-mock.com/boards/1/items" //mock
        
        Alamofire.request(.GET, url, parameters: [:])
            .responseJSON { response in
                
                self.happyList = []
                self.mediocreList = []
                self.unhappyList = []
                
                if let result = response.result.value {
                    
                    let json = JSON(result)
                    
                    for retroItemJson in json["items"].array! {   //mock
                    
//                    for retroItemJson in json.array! {
                        let retroItem = RetroItem(json: retroItemJson)
                        switch retroItem.type {
                        case .Happy:
                            self.happyList.append(retroItem)
                        case .Mediocre:
                            self.mediocreList.append(retroItem)
                        case .Unhappy:
                            self.unhappyList.append(retroItem)
                        }
                    }
                    
                    self.orderArrays()
                    self.tableView.reloadData()
                }
        }
    }
    
    private func orderArrays() {
        happyList.sortInPlace({ $0.likes > $1.likes })
        mediocreList.sortInPlace({ $0.likes > $1.likes })
        unhappyList.sortInPlace({ $0.likes > $1.likes })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        titleLabel.text = "🙂"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 1) {
            return 1;
        }
        
        switch currentList {
        case .Happy:
            return happyList.count
        case .Mediocre:
            return mediocreList.count
        case .Unhappy:
            return unhappyList.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 200
        }
        else {
            return 100
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1) {
            return tableView.dequeueReusableCellWithIdentifier("AddFeedbackCell")!
        }
        
        let i = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier("RetroItemCell") as! RetroItemCellView
        
        
        
        switch currentList {
        case .Happy:
            
            cell.message.text = happyList[i].message
            cell.likes.text = "\(happyList[i].likes)"
            cell.leftUtilityButtons = leftButtons() as [AnyObject]
        case .Mediocre:
            cell.message.text = mediocreList[i].message
            cell.likes.text = "\(mediocreList[i].likes)"
        case .Unhappy:
            cell.message.text = unhappyList[i].message
            cell.likes.text = "\(unhappyList[i].likes)"
        }
        
        return cell
    }
    
    func leftButtons() -> NSArray {
        let buttons = NSMutableArray()
        buttons.sw_addUtilityButtonWithColor(UIColor.lightGrayColor(), title: "Archive")
        buttons.sw_addUtilityButtonWithColor(UIColor.darkGrayColor(), title: "Action")
        return buttons
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
    
    @IBAction func addButtonTapped(sender: UIButton) {
        let addFeedbackVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddFeedback") as! AddFeedbackViewController
        addFeedbackView = sender.superview!
        addFeedbackVC.view.frame = addFeedbackView!.bounds
        addFeedbackVC.list = self.currentList
        addFeedbackVC.delegate = self
        addFeedbackView!.addSubview(addFeedbackVC.view)
        addChildViewController(addFeedbackVC)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let addFeedbackAbsoluteOrigin = addFeedbackView!.convertPoint(addFeedbackView!.frame.origin, toView: view)
        
        keyboardOffset = (addFeedbackAbsoluteOrigin.y + addFeedbackView!.frame.size.height) - keyboardFrame.origin.y

        if keyboardOffset > 0 {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y = -self.keyboardOffset
            })
        }
    }
    
    func keyboardWasHidden(notification: NSNotification) {
        if keyboardOffset > 0 {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y = 0.0            })
        }
        
        keyboardOffset = 0.0
    }
}

