import XCTest
@testable import Files

final class Test_Directory_Create: XCTestCase {
    var temporaryURL: URL!
    let defaultDirectorySize: Int64 = 64
    
    override func setUpWithError() throws {
        temporaryURL = URL.temporaryFileURL()
    }
    
    override func tearDownWithError() throws {
        try temporaryURL.remove()
    }
    
    func test_create() throws {
        let directory = Directory(at: temporaryURL)
        XCTAssertFalse(directory.exists)
        try directory.create()
        XCTAssertTrue(directory.exists)
        XCTAssertEqual(directory.size, defaultDirectorySize)
    }
    
    func test_tryCreate() throws {
        let directory = Directory(at: temporaryURL)
        XCTAssertFalse(directory.exists)
        directory.tryCreate()
        XCTAssertTrue(directory.exists)
        XCTAssertEqual(directory.size, defaultDirectorySize)
    }
    
    static var allTests = [
        ("test_create", test_create),
        ("test_tryCreate", test_tryCreate)
    ]
}
