//
//  RetroItemSpec.swift
//  Retrobox
//
//  Created by Pivotal on 4/14/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import XCTest
import SwiftyJSON
import Quick
import Nimble
@testable import Retrobox

class RetroItemSpec: QuickSpec {
    
    override func spec() {
       
        describe("retro item") {
            
            it("constructs retro item from json") {
                
                let retroItem = RetroItem(json: JSON([
                    "message":"I am a message",
                    "type":"UNHAPPY",
                    "likes":4
                    ]))
                
                expect(retroItem.message).to(equal("I am a message"))
                expect(retroItem.type.hashValue).to(equal(RetroItemType.Unhappy.hashValue))
                expect(retroItem.likes).to(equal(4))
            }
        }
    }
    
}

