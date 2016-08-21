import XCTest
import C7
import Foundation
import gzip
@testable import gzip_openswift

class gzipTests: XCTestCase {

    func testCompressAndUncompress_C7Data() throws {
        let inputString = "hello world hello world hello world hello world hello errbody"
        let input = inputString.data
        let output = try input.gzipCompressed()
        let recoveredInput = try output.gzipUncompressed()
        let recoveredString = String(recoveredInput)
        XCTAssertEqual(recoveredString, inputString)
    }

    func testStream_Uncompress_C7Data() throws {
        let inputData = "H4sICElFQ1cAA2ZpbGUudHh0AMtIzcnJVyjPL8pJUUjLz1dISiwC00DMBQBN/m/HHAAAAA==".fromBase64toC7Data()
        let sourceStream = Drain(for: inputData)
        let outStream = try GzipStream(rawStream: sourceStream, mode: .uncompress)
        let outData = Drain(for: outStream).data
        let outputString = String(outData)
        XCTAssertEqual(outputString, "hello world foo bar foo foo\n")
    }

    func testStream_Compress_C7Data() throws {
        let inputData = "hello world foo bar foo foo\n".data
        let sourceStream = Drain(for: inputData)
        let outStream = try GzipStream(rawStream: sourceStream, mode: .compress)
        let outData = Drain(for: outStream).data
        #if os(Linux)
        let outputString = outData.toNSData().base64EncodedString([])
        #else
        let outputString = outData.toNSData().base64EncodedString(options: [])
        #endif
        XCTAssertEqual(outputString, "H4sIAAAAAAAAA8tIzcnJVyjPL8pJUUjLz1dISiwC00DMBQBN/m/HHAAAAA==")
    }

    func testLarge_Stream_Identity() throws {
        let inputString = Array(repeating: "hello world ", count: 3000).joined(separator: ", ")
        let inputData = inputString.data
        let input = Drain(for: inputData)
        let compressStream = try GzipStream(rawStream: input, mode: .compress)
        let uncompressStream = try GzipStream(rawStream: compressStream, mode: .uncompress)
        let outputData = Drain(for: uncompressStream).data
        let outputString = String(outputData)
        XCTAssertEqual(inputString, outputString)
    }

    func testPerformance_C7Data() throws {
        let inputString = Array(repeating: "hello world ", count: 100000).joined(separator: ", ")
        let input: C7.Data = inputString.data

        measure {
            let output = try! input.gzipCompressed()
            _ = try! output.gzipUncompressed()
        }
    }
}

extension String {
    func toData() -> Foundation.Data {
        return self.data(using: String.Encoding.utf8) ?? Foundation.Data()
    }

    func fromBase64toC7Data() -> C7.Data {
        return NSData(base64Encoded: self, options: [])!.toC7Data()
    }
}

extension Foundation.Data {
    func toString() -> String {
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
}

extension gzipTests {
    static var allTests = [
        ("testCompressAndUncompress_C7Data", testCompressAndUncompress_C7Data),
        ("testStream_Uncompress_C7Data", testStream_Uncompress_C7Data),
        ("testStream_Compress_C7Data", testStream_Compress_C7Data),
        ("testLarge_Stream_Identity", testLarge_Stream_Identity),
        ("testPerformance_C7Data", testPerformance_C7Data)
    ]
}
