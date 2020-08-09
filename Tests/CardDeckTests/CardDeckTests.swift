import XCTest
@testable import CardDeck

final class CardDeckTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CardDeck().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
