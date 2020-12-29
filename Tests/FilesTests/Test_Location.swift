import XCTest
@testable import Files

final class Test_Location: XCTestCase {
    var location: Location!
    let content = "Hello World"
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        try content.data(using: .utf8)!.write(to: temporaryURL)
        location = temporaryURL
    }
    
    override func tearDownWithError() throws {
        try location.remove()
    }
    
    func test_nonExistendURL() throws {
        let name = location.nameExcludingExtension
        let nonExistendURL1 = location.nonExistendURL
        
        try content.data(using: .utf8)!.write(to: nonExistendURL1)
        XCTAssertTrue(nonExistendURL1.exists)
        XCTAssertEqual(nonExistendURL1.size, Int64(content.count))
        XCTAssertEqual(nonExistendURL1.name, "\(name)_1")
        
        let nonExistendURL2 = location.nonExistendURL
        try content.data(using: .utf8)!.write(to: nonExistendURL2)
        XCTAssertTrue(nonExistendURL2.exists)
        XCTAssertEqual(nonExistendURL2.size, Int64(content.count))
        XCTAssertEqual(nonExistendURL2.name, "\(name)_2")
        
        XCTAssertTrue(nonExistendURL1.tryRemove())
        
        let nonExistendURL3 = location.nonExistendURL
        try content.data(using: .utf8)!.write(to: nonExistendURL3)
        XCTAssertTrue(nonExistendURL1.exists)
        XCTAssertEqual(nonExistendURL1.size, Int64(content.count))
        XCTAssertEqual(nonExistendURL1.name, "\(name)_1")
        
        XCTAssertTrue(nonExistendURL2.tryRemove())
        XCTAssertTrue(nonExistendURL3.tryRemove())
    }

    static var allTests = [
        ("test_nonExistendURL", test_nonExistendURL),
    ]
}
