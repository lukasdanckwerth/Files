import XCTest

import FilesTests

var tests = [XCTestCaseEntry]()
tests += Test_LogFile.allTests()
tests += Test_MarkdownLogFile.allTests()
tests += Test_URL_Appending_Convenience.allTests()
XCTMain(tests)
