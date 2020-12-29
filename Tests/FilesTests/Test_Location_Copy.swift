import XCTest
@testable import Files

final class Test_Location_Copy: XCTestCase {
    var location: Location!
    var temporaryTargetDirectory: Directory!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        let data = "Hello World".data(using: .utf8)!
        try data.write(to: temporaryURL)
        location = temporaryURL
        
        let temporaryDirectoryURL = try URL.temporaryDirectoryURL()
        temporaryTargetDirectory = Directory(at: temporaryDirectoryURL)
    }
    
    override func tearDownWithError() throws {
        try location.remove()
        try temporaryTargetDirectory.remove()
    }
    
    func test_copy() throws {
        let targetURL = try location.copy(to: temporaryTargetDirectory.url)
        XCTAssertTrue(targetURL!.exists)
        XCTAssertEqual(targetURL!.size, location.size)
    }
    
    func test_tryCopy() throws {
        let targetURL = temporaryTargetDirectory.file(named: location.filename)
        XCTAssertTrue(location.tryCopy(to: temporaryTargetDirectory.url))
        XCTAssertEqual(location.size, targetURL.size)
    }
    
    func test_copy_Directory() throws {
        let targetURL = try location.copy(to: temporaryTargetDirectory)
        XCTAssertTrue(targetURL!.exists)
        XCTAssertEqual(targetURL!.size, location.size)
    }
    
    func test_tryCopy_Directory() throws {
        let targetURL = temporaryTargetDirectory.file(named: location.filename)
        XCTAssertTrue(location.tryCopy(to: temporaryTargetDirectory))
        XCTAssertEqual(location.size, targetURL.size)
    }
    
    static var allTests = [
        ("test_copy", test_copy),
        ("test_tryCopy", test_tryCopy),
        ("test_copy_Directory", test_copy_Directory),
        ("test_tryCopy_Directory", test_tryCopy_Directory)
    ]
}
