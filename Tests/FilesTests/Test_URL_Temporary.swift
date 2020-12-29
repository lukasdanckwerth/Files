import XCTest
@testable import Files

final class Test_URL_Temporary: XCTestCase {
    
    func test_temporaryFileWithExtension() throws {
        let url = URL.home
        let directoryURL = url.appendingDirectoryComponent("my_directory")
        XCTAssertEqual(directoryURL.pathExtension, "")
        XCTAssertEqual(directoryURL.filename, "my_directory")
        XCTAssertEqual(directoryURL.filenameWithoutExtension, "my_directory")
    }
    
    func test_createTemporaryFileURL() throws {
        let url = URL.home
        let fileURL = url.appendingFileComponent("my_file", withExtension: "my_extension")
        XCTAssertEqual(fileURL.pathExtension, "my_extension")
        XCTAssertEqual(fileURL.filename, "my_file.my_extension")
        XCTAssertEqual(fileURL.filenameWithoutExtension, "my_file")
    }

    static var allTests = [
        ("test_temporaryFileWithExtension", test_temporaryFileWithExtension),
        ("test_createTemporaryFileURL", test_createTemporaryFileURL)
    ]
}
