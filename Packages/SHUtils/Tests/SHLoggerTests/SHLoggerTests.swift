import XCTest
@testable import SHLogger

final class SHLoggerTests: XCTestCase {
    func testLoggerLevelComparableCorrectness() async {
        XCTAssertTrue(SHLogger.Level.debug    < .trace)
        XCTAssertTrue(SHLogger.Level.trace    < .notice)
        XCTAssertTrue(SHLogger.Level.notice   < .log)
        XCTAssertTrue(SHLogger.Level.log      < .info)
        XCTAssertTrue(SHLogger.Level.info     < .warning)
        XCTAssertTrue(SHLogger.Level.warning  < .error)
        XCTAssertTrue(SHLogger.Level.error    < .critical)
        XCTAssertTrue(SHLogger.Level.critical < .fault)
    }
    
    func testDebugPrintsWithAllLevels() async {
        let logger = SHLogger(level: .debug, subsystemName: "Test", category: "test")
        let expectation = XCTestExpectation(description: "Logger is called")
        logger(scope: .debug) {
            $0.debug("This should be printed")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation])
    }
    
    func testDebugDoesNotPrintWithInfoLevel() async {
        let logger = SHLogger(subsystemName: "Test", category: "test")
        let expectation = XCTestExpectation(description: "Logger is not called")
        expectation.isInverted = true
        logger(scope: .debug) {
            $0.log("This should not be printed")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
