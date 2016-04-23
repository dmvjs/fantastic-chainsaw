//
//  NotRegexTests.swift
//  NotRegexTests
//
//  Created by Kirk Elliott on 4/23/16.
//  Copyright © 2016 dmvjs. All rights reserved.
//

import XCTest

class NotRegexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_find () {
        XCTAssertEqual("f̤̬͕̳͇̰̗̿͑̏̇̕̕͟͝ą͚͓͇̥̂́̽̍̕͢ņ͙͉̣̪̞͙͎͌́̄͂͐̕͟t̸̻̭̝̣̳̯̙͍̥̿̍̐͂̀̈́̓̀̚͜͠ą̸̣̥̫̠̤̝̓̇͊̒̊̂̉͜͟s̸̛̳̮̪͍̗̈̄̐̈͂̏̈͐ț̵͓̤̯͇̩̩͖̀͆̽̕͘͝ǐ̸̡̨̨̫̖̒̆̑̑̅͐̚ć̸̬͈̫͚̮͂̈̀́̍̏͑̈́͘ͅ-̴̼̪͙̮̗̀̓͗͐͗́̄͘͢ç̶̠̦̝̝̼̻̈̔̑͊̑̾͘̕ḥ̶̡̢̜͚͉̘̖̥͙̏̏͒̈̃͑͊̚͞â̴̯̱̳̼̲̭̐̄͛͌͟͠͡͠ỉ̷̢͚̰͇̗̲͇̅͛̀̀̾͢ͅn͇̣͓͍̑̇̔̀̇̽͊̈͐͜͢͠s̡̛̜͖͔͉̬͂̑̈̐͂̓͢á̵̛̛̺̹̘̤͈̮͇̫̈́͐͐͋͘͟͠w̦̗͇̱̥͓̖͉̯̥̉̔̾̽̽͋̋͛̚".find("ç̶̠̦̝̝̼̻̈̔̑͊̑̾͘̕")?.indexes, [10])
        
        
        
        XCTAssertEqual("🍣sashimi!!!🍣".find("🍣")?.indexes, [0,11])
        XCTAssertEqual("this is a sample".find(" ")?.indexes, [4,7,9])
        XCTAssertEqual("this is a sample".find("is")?.indexes, [2,5])
        XCTAssertEqual("this is a sample".find(Array("is".characters))?.indexes, [2,3,5,6,10])
        XCTAssertNil("nomatchexists".find(" ")?.indexes)
    }
    
    func test_findWithReplace () {
        XCTAssertEqual("🍣sashimi!!!🍣".find("🍣")?.replaceWith("🍺").find("sashimi!!!")?.replaceWith("beer!!!!"), "🍺beer!!!!🍺")
    }
    
    func test_FindWithRange() {
        XCTAssertEqual("this that".findWithRange("az"), [0,1,2,3,5,6,7,8])
    }
    
    func test_findFirstWithRange () {
        XCTAssertEqual("this that".findFirstWithRange("az"), 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
