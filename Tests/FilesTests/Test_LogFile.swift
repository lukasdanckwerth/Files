import XCTest
@testable import Files

final class Test_LogFile: XCTestCase {
    
    func test_afterAddingContent_fileExists() throws {
        let url = URL.createTemporaryFileURL(withExtension: "log")
        let file = LogFile(at: url)
        file.log("Hello World", terminator: "")
        XCTAssertTrue(file.exists)
        let content = try String(contentsOf: file.fileURL)
        XCTAssertEqual(content, "Hello World")
        XCTAssertTrue(file.tryRemove())
    }

    static var allTests = [
        ("test_afterAddingContent_fileExists", test_afterAddingContent_fileExists),
    ]
}
