import XCTest
@testable import ZewoGzipTests

XCTMain([
	 testCase(gzipTests.allTests),
	 testCase(GzipMiddlewareTests.allTests),
])
