import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Test_LogFile.allTests),
        testCase(Test_MarkdownLogFile.allTests),
    ]
}
#endif
