//
//  VolunteerHoursTests.swift
//  VolunteerHoursTests
//
//  Created by Paul Inventado on 3/3/22.
//

import XCTest
@testable import VolunteerHours
import SwiftUI

class VolunteerHoursTests: XCTestCase {

    func testClassImplementations() {
        let binding = Binding<String>(get: { "temp"}, set: {_ in })
        let _ = Report(message: binding, volunteer: Volunteer(name: "", age: 0))
        let _ = VolunteerDetails()
        let _ = VolunteerManager()
    }
    
    func testReportStructUsed() {
        let content = Mirror(reflecting: VolunteerForm().body)
        let hasReport = content.description.contains("Report")
        XCTAssert(hasReport)
    }

}
