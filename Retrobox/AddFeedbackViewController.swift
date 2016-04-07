//
//  AddFeedbackViewController.swift
//  Retrobox
//
//  Created by Pivotal on 4/6/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit
import Alamofire

protocol AddFeedbackViewControllerDelegate {
    func postWasSuccessful()
}

class AddFeedbackViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    var delegate: AddFeedbackViewControllerDelegate?
    var list: RetroItemType?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        input.delegate = self
        input.becomeFirstResponder()
    }
    
    func sendFeedback() {
        let parameters: [String: AnyObject]? = [
            "board_id": 1,
            "message": input.text!,
            "type": list!.rawValue
        ]
        
        Alamofire.request(.POST, "http://retrobox-api.cfapps.io/items", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                if response.result.isSuccess {
                    self.delegate?.postWasSuccessful()
                }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendFeedback()
        input.enabled = false
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        return true
    }
}