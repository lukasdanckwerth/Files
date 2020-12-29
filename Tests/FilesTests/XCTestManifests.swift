import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Test_Location_Attributes.allTests),
        testCase(Test_Location_Backup.allTests),
        testCase(Test_Location_Copy.allTests),
        testCase(Test_Location_Remove.allTests),
        testCase(Test_Location.allTests),
        
        testCase(Test_LogFile.allTests),
        testCase(Test_MarkdownLogFile.allTests),
        
        testCase(Test_URL_Appending_Convenience.allTests),
        testCase(Test_URL_Temporary.allTests)
    ]
}
#endif
