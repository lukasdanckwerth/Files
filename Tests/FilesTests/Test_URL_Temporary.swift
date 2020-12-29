import XCTest
@testable import Files

final class Test_URL_Temporary: XCTestCase {
    
    func test_temporaryFileWithExtension() throws {
        let temporaryURL = URL(temporaryFileWithExtension: "my_extension")
        XCTAssertEqual(temporaryURL.pathExtension, "my_extension")
        XCTAssertEqual(temporaryURL.enclosingDirectoryURL, URL.temporary)
        let lengthOfUUIDString = 36
        XCTAssertEqual(temporaryURL.nameExcludingExtension.count, lengthOfUUIDString)
        XCTAssertFalse(temporaryURL.exists)
    }
    
    func test_createTemporaryFileURL_withExtension() throws {
        let temporaryURL = URL.temporaryFileURL(withExtension: "my_extension")
        XCTAssertEqual(temporaryURL.pathExtension, "my_extension")
        XCTAssertEqual(temporaryURL.enclosingDirectoryURL, URL.temporary)
        let lengthOfUUIDString = 36
        XCTAssertEqual(temporaryURL.nameExcludingExtension.count, lengthOfUUIDString)
        XCTAssertFalse(temporaryURL.exists)
    }
    
    func test_createTemporaryFileURL() throws {
        let temporaryURL = URL.temporaryFileURL()
        XCTAssertEqual(temporaryURL.pathExtension, "")
        XCTAssertEqual(temporaryURL.enclosingDirectoryURL, URL.temporary)
        let lengthOfUUIDString = 36
        XCTAssertEqual(temporaryURL.nameExcludingExtension.count, lengthOfUUIDString)
        XCTAssertFalse(temporaryURL.exists)
    }
    
    func test_createTemporaryDirectoryURL() throws {
        let temporaryURL = try URL.temporaryDirectoryURL()
        XCTAssertEqual(temporaryURL.enclosingDirectoryURL, URL.temporary)
        let lengthOfUUIDString = 36
        XCTAssertEqual(temporaryURL.nameExcludingExtension.count, lengthOfUUIDString)
        XCTAssertTrue(temporaryURL.exists)
        XCTAssertTrue(temporaryURL.isDirectory)
        try temporaryURL.remove()
    }

    static var allTests = [
        ("test_temporaryFileWithExtension", test_temporaryFileWithExtension),
        ("test_createTemporaryFileURL_withExtension", test_createTemporaryFileURL_withExtension),
        ("test_createTemporaryFileURL", test_createTemporaryFileURL),
        ("test_createTemporaryDirectoryURL", test_createTemporaryDirectoryURL)
    ]
}
