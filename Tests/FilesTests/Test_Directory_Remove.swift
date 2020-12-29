import XCTest
@testable import Files

final class Test_Directory_Remove: XCTestCase {
    var directory: Directory!
    let defaultDirectorySize: Int64 = 64
    let sampleData = String("Hello World").data(using: .utf8)!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        directory = Directory(at: temporaryURL, create: true)
        
        try sampleData.write(to: directory.fileURL(name: "my_file_1", extension: "txt"))
        try sampleData.write(to: directory.fileURL(name: "my_file_2", extension: "txt"))
        try sampleData.write(to: directory.fileURL(name: "my_file_1", extension: "md"))
        try sampleData.write(to: directory.fileURL(name: "my_file_2", extension: "md"))
        try sampleData.write(to: directory.fileURL(name: "my_file_1", extension: "log"))
    }
    
    override func tearDownWithError() throws {
        try directory.remove()
    }
    
    func test_removeContents() throws {
        XCTAssertTrue(directory.exists)
        XCTAssertFalse(directory.isEmpty)
        try directory.removeContents()
        XCTAssertTrue(directory.exists)
        XCTAssertTrue(directory.isEmpty)
    }
    
    func test_removeContentsWithExtensions() throws {
        XCTAssertTrue(directory.exists)
        XCTAssertFalse(directory.isEmpty)
        XCTAssertEqual(directory.contents.count, 5)
        try directory.removeContents(withExtensions: ["txt"])
        XCTAssertEqual(directory.contents.count, 3)
        try directory.removeContents(withExtensions: ["md"])
        XCTAssertEqual(directory.contents.count, 1)
    }
    
    func test_tryRemoveContents() throws {
        XCTAssertTrue(directory.exists)
        XCTAssertFalse(directory.isEmpty)
        XCTAssertTrue(directory.tryRemoveContents())
        XCTAssertTrue(directory.exists)
        XCTAssertTrue(directory.isEmpty)
    }
    
    func test_removeAndCreate() throws {
        let creationDate = directory.creationDate
        XCTAssertNotNil(creationDate)
        XCTAssertTrue(directory.exists)
        XCTAssertTrue(directory.removeAndCreate())
        XCTAssertTrue(directory.exists)
        XCTAssertNotEqual(directory.creationDate, creationDate)
    }
    
    static var allTests = [
        ("test_removeContents", test_removeContents),
        ("test_removeContentsWithExtensions", test_removeContentsWithExtensions),
        ("test_tryRemoveContents", test_tryRemoveContents),
        ("test_removeAndCreate", test_removeAndCreate)
    ]
}
