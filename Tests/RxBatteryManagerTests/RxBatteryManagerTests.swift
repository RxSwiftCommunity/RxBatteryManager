import XCTest
@testable import RxBatteryManager

final class RxBatteryManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RxBatteryManager().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
