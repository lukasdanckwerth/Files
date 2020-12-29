import XCTest
@testable import Files

final class Test_Location_Remove: XCTestCase {
    var location: Location!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        let data = "Hello World".data(using: .utf8)!
        try data.write(to: temporaryURL)
        location = temporaryURL
    }
    
    func test_remove() throws {
        XCTAssertTrue(location.exists)
        try location.remove()
        XCTAssertFalse(location.exists)
    }
    
    func test_tryRemove() {
        XCTAssertTrue(location.exists)
        XCTAssertTrue(location.tryRemove())
        XCTAssertFalse(location.exists)
    }
    
    func test_tryRemoveIfExists() {
        XCTAssertTrue(location.exists)
        XCTAssertTrue(location.removeIfExists())
        XCTAssertFalse(location.exists)
        XCTAssertTrue(location.removeIfExists())
    }
    
    static var allTests = [
        ("test_remove", test_remove),
        ("test_tryRemove", test_tryRemove),
        ("test_tryRemoveIfExists", test_tryRemoveIfExists)
    ]
}
