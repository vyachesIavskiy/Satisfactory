import XCTest
@testable import SHLogger

final class SHLoggerTests: XCTestCase {
    private let stringProtocol: any StringProtocol = "String Protocol"
    private let customDebugStringConvertible: CustomDebugStringConvertible = "Custom Debug String Convertible"
    private let customStringConvertible: CustomStringConvertible = "Custom String Convertible"
    private let losslessStringConvertible: LosslessStringConvertible = "Lossless String Convertible"
    private let customDebugLosslessStringConvertible: (CustomDebugStringConvertible & LosslessStringConvertible) = "Custom Debug & Lossless String Convertible"
    private let customDebugCustomStringConvertible: (CustomDebugStringConvertible & LosslessStringConvertible) = "Custom Debug & Custom String Convertible"
    
    private let error: Error = TestError.testError
    private let localizedError: LocalizedError = TestLocalizedError.testLocalizedError
    private let customNSError: CustomNSError = TestCustomNSError.testCustomNSError
    
    func testDisabled() {
        let logger = SHLogger(subsystemName: "SHLoggerTests", category: "Disabled")
        
        logger.isEnabled = false
        
        logger.log("This message should not appear in log")
        
        XCTAssertTrue(logger.logs.isEmpty)
    }
    
    func testDebug() {
        let logger = SHLogger(subsystemName: "SHLoggerTests", category: "Debug")
        
        logger.debug(stringProtocol)
        logger.debug(customDebugStringConvertible)
        logger.debug(customStringConvertible)
        logger.debug(losslessStringConvertible)
        logger.debug(customDebugLosslessStringConvertible)
        logger.debug(customDebugCustomStringConvertible)
        
        XCTAssertEqual(logger.logs, [
            "String Protocol",
            #""Custom Debug String Convertible""#,
            "Custom String Convertible",
            "Lossless String Convertible",
            #""Custom Debug & Lossless String Convertible""#,
            #""Custom Debug & Custom String Convertible""#
        ])
    }
    
    func testInfo() {
        let logger = SHLogger(subsystemName: "SHLoggerTests", category: "Info")
        
        logger.info(stringProtocol)
        logger.info(customDebugStringConvertible)
        logger.info(customStringConvertible)
        logger.info(losslessStringConvertible)
        logger.info(customDebugLosslessStringConvertible)
        logger.info(customDebugCustomStringConvertible)
        
        XCTAssertEqual(logger.logs, [
            "String Protocol",
            #""Custom Debug String Convertible""#,
            "Custom String Convertible",
            "Lossless String Convertible",
            "Custom Debug & Lossless String Convertible",
            "Custom Debug & Custom String Convertible"
        ])
    }
    
    func testError() {
        let logger = SHLogger(subsystemName: "SHLoggerTests", category: "Error")
        
        logger.error(stringProtocol)
        logger.error(customDebugStringConvertible)
        logger.error(customStringConvertible)
        logger.error(losslessStringConvertible)
        logger.error(customDebugLosslessStringConvertible)
        logger.error(customDebugCustomStringConvertible)
        
        logger.error(error)
        logger.error(localizedError)
        logger.error(customNSError)
        
        XCTAssertEqual(logger.logs, [
            "String Protocol",
            #""Custom Debug String Convertible""#,
            "Custom String Convertible",
            "Lossless String Convertible",
            #""Custom Debug & Lossless String Convertible""#,
            #""Custom Debug & Custom String Convertible""#,
            
            "testError",
            "testLocalizedError",
            "testCustomNSError"
        ])
    }
    
    func testFault() {
        let logger = SHLogger(subsystemName: "SHLoggerTests", category: "Fault")
        
        logger.fault(stringProtocol)
        logger.fault(customDebugStringConvertible)
        logger.fault(customStringConvertible)
        logger.fault(losslessStringConvertible)
        logger.fault(customDebugLosslessStringConvertible)
        logger.fault(customDebugCustomStringConvertible)
        
        logger.fault(error)
        logger.fault(localizedError)
        logger.fault(customNSError)
        
        XCTAssertEqual(logger.logs, [
            "String Protocol",
            #""Custom Debug String Convertible""#,
            "Custom String Convertible",
            "Lossless String Convertible",
            #""Custom Debug & Lossless String Convertible""#,
            #""Custom Debug & Custom String Convertible""#,
            
            "testError",
            "testLocalizedError",
            "testCustomNSError"
        ])
    }
}

private extension SHLoggerTests {
    enum TestError: Error {
        case testError
    }
    
    enum TestLocalizedError: LocalizedError {
        case testLocalizedError
    }
    
    enum TestCustomNSError: CustomNSError {
        case testCustomNSError
    }
}
