//
//  VolunteerHoursUITests.swift
//  VolunteerHoursUITests
//
//  Created by Paul Inventado on 3/3/22.
//

import XCTest

class VolunteerHoursUITests: XCTestCase {
    
    override class func setUp() {
        XCUIDevice.shared.orientation = .portrait
    }
    
    func takeScreenshot(name: String) {
      let fullScreenshot = XCUIScreen.main.screenshot()

      let screenshot = XCTAttachment(uniformTypeIdentifier: "public.png", name: "Screenshot-\(name)-\(UIDevice.current.name).png", payload: fullScreenshot.pngRepresentation, userInfo: nil)
      screenshot.lifetime = .keepAlways
      add(screenshot)
    }
    
    func testStartPage() {
        let app = XCUIApplication()
        app.launch()
        var allStaticText = ""
        for text in app.staticTexts.allElementsBoundByIndex {
            allStaticText += text.label
        }
        XCTAssertEqual(allStaticText.trimmingCharacters(in: .whitespaces), "List of volunteers:")
        XCTAssert(app.staticTexts["List of volunteers: "].exists)
        XCTAssert(app.buttons["Add more volunteers"].exists)
    }
    
    func testAddVolunteerTap() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add more volunteers"].tap()
        
        XCTAssert(app.staticTexts["Volunteer Form"].exists)
    }
    
    func testVolunteerFormAddVolunteerButton() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add more volunteers"].tap()
        
        XCTAssert(app.buttons["Add Volunteer"].exists)
    }
    
    func testVolunteerFormAddVolunteer() {
        // If you can add volunteers correctly but the test fails, try disabling the hardware keyboard
        // Open the emulator select I/O > Keyboard > Connect Hardware Keyboard (uncheck)
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add more volunteers"].tap()
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Paul")
        app.keyboards.buttons["return"].tap()
        app.textFields["Age"].tap()
        app.textFields["Age"].typeText("28")
        app.keyboards.buttons["return"].tap()
        app.buttons["Add Volunteer"].tap()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Paula")
        app.keyboards.buttons["return"].tap()
        app.textFields["Age"].tap()
        app.textFields["Age"].typeText("30")
        app.keyboards.buttons["return"].tap()
        app.buttons["Add Volunteer"].tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssert(app.staticTexts["Paul (28)"].exists)
        XCTAssert(app.staticTexts["Paula (30)"].exists)
    }
    
    func testVolunteerDetailsUpdate() {
        // If you can add volunteers correctly but the test fails, try disabling the hardware keyboard
        // Open the emulator select I/O > Keyboard > Connect Hardware Keyboard (uncheck)
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add more volunteers"].tap()
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Paul")
        app.keyboards.buttons["return"].tap()
        app.textFields["Age"].tap()
        app.textFields["Age"].typeText("28")
        app.keyboards.buttons["return"].tap()
        app.buttons["Add Volunteer"].tap()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Paula")
        app.keyboards.buttons["return"].tap()
        app.textFields["Age"].tap()
        app.textFields["Age"].typeText("30")
        app.keyboards.buttons["return"].tap()
        app.buttons["Add Volunteer"].tap()
        
        app.buttons["See volunteer hour details."].tap()

        XCTAssert(app.staticTexts["There are currently 2 volunteers."].exists)
    }
}
