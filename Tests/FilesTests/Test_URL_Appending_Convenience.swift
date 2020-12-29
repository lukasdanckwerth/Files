import XCTest
@testable import Files

final class Test_URL_Appending_Convenience: XCTestCase {
    
    func test_appendingFileComponent() throws {
        let url = URL.home
        let fileURL = url.appendingFileComponent("my_file", withExtension: "my_extension")
        XCTAssertEqual(fileURL.pathExtension, "my_extension")
        XCTAssertEqual(fileURL.name, "my_file.my_extension")
        XCTAssertEqual(fileURL.nameExcludingExtension, "my_file")
    }
    
    func test_appendingDirectoryComponent() throws {
        let url = URL.home
        let directoryURL = url.appendingDirectoryComponent("my_directory")
        XCTAssertEqual(directoryURL.pathExtension, "")
        XCTAssertEqual(directoryURL.name, "my_directory")
        XCTAssertEqual(directoryURL.nameExcludingExtension, "my_directory")
    }

    static var allTests = [
        ("test_appendingFileComponent", test_appendingFileComponent),
        ("test_appendingDirectoryComponent", test_appendingDirectoryComponent)
    ]
}
