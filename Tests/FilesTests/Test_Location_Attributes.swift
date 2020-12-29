import XCTest
@testable import Files

final class Test_Location_Attributes: XCTestCase {
    var location: Location!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL()
        let data = String(repeating: "Hello World", count: 10).data(using: .utf8)!
        try data.write(to: temporaryURL)
        location = temporaryURL
    }
    
    override func tearDownWithError() throws {
        try location.remove()
    }
    
    func test_receiveModificationDate() throws {
        let modificationDate = location.modificationDate
        XCTAssertNotNil(modificationDate)
        guard let intervall = modificationDate?.timeIntervalSinceNow else { throw NSError() }
        XCTAssertGreaterThan(intervall, -10)
    }
    
    func test_receiveCreationDate() throws {
        let creationDate = location.creationDate
        XCTAssertNotNil(creationDate)
        guard let intervall = creationDate?.timeIntervalSinceNow else { throw NSError() }
        XCTAssertGreaterThan(intervall, -10)
    }
    
    func test_receiveType() throws {
        let type = location.type
        XCTAssertNotNil(type)
        XCTAssertEqual(type, "NSFileTypeRegular")
    }
    
    func test_receiveSize() throws {
        let size = location.size
        XCTAssertNotNil(size)
        XCTAssertEqual(size, 110)
    }
    
    func test_receiveSizeFormatted() throws {
        let formattedSize = location.formattedSize
        XCTAssertNotNil(formattedSize)
        XCTAssertEqual(formattedSize, "110 bytes")
    }

    static var allTests = [
        ("test_receiveModificationDate", test_receiveModificationDate),
        ("test_receiveCreationDate", test_receiveCreationDate),
        ("test_receiveType", test_receiveType),
        ("test_receiveSize", test_receiveSize),
        ("test_receiveSizeFormatted", test_receiveSizeFormatted)
    ]
}
