import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IOS6SwiftUITests.allTests),
    ]
}
#endif
