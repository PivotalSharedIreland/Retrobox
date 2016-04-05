//
//  RetroboxUITests.swift
//  RetroboxUITests
//
//  Created by Pivotal on 4/5/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import XCTest
import UIKit
import Nimble

class RetroboxUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRetroPageExists() {
        let addButton = app.buttons["Add"]
        expect(addButton.exists).to(beFalse())
    }
    
}
