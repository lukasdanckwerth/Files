import XCTest

import FilesTests

var tests = [XCTestCaseEntry]()
tests += Test_Location_Attributes.allTests()
tests += Test_Location_Backup.allTests()
tests += Test_Location_Copy.allTests()
tests += Test_Location_Remove.allTests()
tests += Test_Location.allTests()

tests += Test_LogFile.allTests()
tests += Test_MarkdownLogFile.allTests()

tests += Test_URL_Appending_Convenience.allTests()
tests += Test_URL_Appending_Temporary.allTests()
XCTMain(tests)
