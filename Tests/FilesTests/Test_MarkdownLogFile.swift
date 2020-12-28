import XCTest
@testable import Files

final class Test_MarkdownLogFile: XCTestCase {
    
    func test_afterAddingContent_fileExists() throws {
        let url = URL.createTemporaryFileURL(withExtension: "log.md")
        let file = MarkdownLogFile(at: url)
        file.h1("Headline 1")
        file.h2("Headline 2")
        XCTAssertTrue(file.exists)
        let content = try String(contentsOf: file.fileURL)
        let lines = content.components(separatedBy: .newlines)
        XCTAssertTrue(lines[0] == "# Headline 1", "invalid line: \(lines[0])")
        XCTAssertTrue(lines[1] == "## Headline 2", "invalid line: \(lines[1])")
        XCTAssertTrue(file.tryRemove())
    }

    static var allTests = [
        ("test_afterAddingContent_fileExists", test_afterAddingContent_fileExists),
    ]
}
