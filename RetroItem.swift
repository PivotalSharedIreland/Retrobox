//
//  RetroItem.swift
//  Retrobox
//
//  Created by Pivotal on 4/5/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation
import SwiftyJSON

enum RetroItemType {
    case Happy
    case Mediocre
    case Unhappy
}

enum RetroItemStatus {
    case Active
    case Archived
}

class RetroItem {
    
//    var id: String
//    var boardId: String
    var type: RetroItemType
    var message: String
//    var status: RetroItemStatus
//    var creationDate: NSDate
//    var lastModifiedDate: NSDate
//    var likes: Int
    
    init(json: JSON) {
        message = json["message"].stringValue
        switch json["type"].stringValue {
            case "HAPPY":
                type = .Happy
            case "MEDIOCRE":
                type = .Mediocre
        default: //case "SAD":
                type = .Unhappy
        }
    }
    
    
//    {
//    "id": 83838389,
//    "board_id": 1,
//    "type": "HAPPY",
//    "message": "I'm a message",
//    "status": "ACTIVE",
//    "creation_date": "2006-10-01T20:30:00Z",
//    "last_modified_date": "2006-10-01T20:30:00Z",
//    "likes": 0
//    },
}