import XCTest
@testable import BBToast

final class BBToastTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BBToast().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
