//
//  RetroItem.swift
//  Retrobox
//
//  Created by Pivotal on 4/5/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation
import SwiftyJSON

enum RetroItemType: String {
    case Happy = "HAPPY"
    case Mediocre = "MEDIOCRE"
    case Unhappy = "UNHAPPY"
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
    var likes: Int
    
    init(json: JSON) {
        message = json["message"].stringValue
        type = typeFromString(json["type"].stringValue)
        likes = json["likes"].int!
    }
}

private func typeFromString(type: String) -> RetroItemType {
    switch type {
    case "HAPPY":
        return .Happy
    case "MEDIOCRE":
        return .Mediocre
    default: //case "SAD":
        return .Unhappy
    }
}