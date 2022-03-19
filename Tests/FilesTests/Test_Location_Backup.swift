import XCTest
@testable import Files

final class Test_Location_Backup: XCTestCase {
    var location: Location!
    
    override func setUpWithError() throws {
        let temporaryURL = URL.temporaryFileURL(withExtension: "my_extension")
        let data = "Hello World".data(using: .utf8)!
        try data.write(to: temporaryURL)
        location = temporaryURL
    }
    
    override func tearDownWithError() throws {
        try location.remove()
    }
    
    func test_backupURL() {
        let backupURL = location.backupURL
        XCTAssertFalse(backupURL.exists)
        XCTAssertEqual(backupURL.extension, "my_extension")
        XCTAssertTrue(backupURL.nameExcludingExtension.hasPrefix(location.nameExcludingExtension))
        let dateSuffix = String(backupURL.nameExcludingExtension.dropFirst(location.nameExcludingExtension.count))
        let dateSuffixLength = 22
        XCTAssertEqual(dateSuffix.count, dateSuffixLength)
    }
    
    func test_backup() throws {
        let backupURL = try location.backup()
        XCTAssertTrue(backupURL!.exists)
        XCTAssertEqual(backupURL!.extension, "my_extension")
        XCTAssertEqual(backupURL!.size, Int64("Hello World".count))
        XCTAssertTrue(backupURL!.tryRemove())
    }
    
    func test_tryBackup() {
        let backupURL = location.tryBackup()
        XCTAssertTrue(backupURL!.exists)
        XCTAssertEqual(backupURL!.extension, "my_extension")
        XCTAssertEqual(backupURL!.size, Int64("Hello World".count))
        XCTAssertTrue(backupURL!.tryRemove())
    }
    
    static var allTests = [
        ("test_backupURL", test_backupURL),
        ("test_backup", test_backup),
        ("test_tryBackup", test_tryBackup)
    ]
}
