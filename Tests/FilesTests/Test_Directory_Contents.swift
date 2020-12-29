import XCTest
@testable import Files

final class Test_Directory_Contents: XCTestCase {
    var directory: Directory!
    let defaultDirectorySize: Int64 = 64
    let sampleData = String("Hello World").data(using: .utf8)!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        directory = Directory(at: temporaryURL, create: true)
    }
    
    override func tearDownWithError() throws {
        try directory.remove()
    }
    
    func test_contents() throws {
        let fileURL = directory.fileURL(name: "my_file")
        try sampleData.write(to: fileURL)
        try sampleData.write(to: fileURL.nonExistendURL)
        XCTAssertEqual(directory.contents.count, 2)
        try sampleData.write(to: fileURL.nonExistendURL)
        XCTAssertEqual(directory.contents.count, 3)
    }
    
    func test_isEmpty() throws {
        XCTAssertTrue(directory.isEmpty)
        let fileURL = directory.fileURL(name: "my_file")
        try sampleData.write(to: fileURL)
        XCTAssertFalse(directory.isEmpty)
    }
    
    func test_emptyDirectory_recursiveSize_isZero() throws {
        XCTAssertEqual(directory.size, defaultDirectorySize)
        XCTAssertEqual(directory.recursiveSize, 0)
    }
    
    func test_directory_recursiveSize() throws {
        let fileURL = directory.fileURL(name: "my_file")
        try sampleData.write(to: fileURL)
        try sampleData.write(to: fileURL.nonExistendURL)
        try sampleData.write(to: fileURL.nonExistendURL)
        XCTAssertEqual(directory.recursiveSize, Int64(sampleData.count * 3))
    }
    
    func test_formattedRecursiveSize() throws {
        XCTAssertEqual(directory.size, defaultDirectorySize)
        XCTAssertEqual(directory.formattedRecursiveSize, "Zero KB")
    }
    
    static var allTests = [
        ("test_contents", test_contents),
        ("test_isEmpty", test_isEmpty),
        ("test_emptyDirectory_recursiveSize_isZero", test_emptyDirectory_recursiveSize_isZero),
        ("test_directory_recursiveSize", test_directory_recursiveSize),
        ("test_formattedRecursiveSize", test_formattedRecursiveSize)
    ]
}
