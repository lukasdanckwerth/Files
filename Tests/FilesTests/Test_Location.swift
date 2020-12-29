import XCTest
@testable import Files

final class Test_Location: XCTestCase {
    
    func test_afterAddingContent_fileExists() throws {
        let url = URL.temporaryFileURL(withExtension: "log")
        let file = LogFile(at: url)
        file.log("Hello World", terminator: "")
        XCTAssertTrue(file.exists)
        let content = try String(contentsOf: file.url)
        XCTAssertEqual(content, "Hello World")
        XCTAssertTrue(file.tryRemove())
    }

    static var allTests = [
        ("test_afterAddingContent_fileExists", test_afterAddingContent_fileExists),
    ]
}
