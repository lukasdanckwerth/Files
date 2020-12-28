import XCTest

import FilesTests

var tests = [XCTestCaseEntry]()
tests += Test_LogFile.allTests()
tests += Test_MarkdownLogFile.allTests()
XCTMain(tests)
