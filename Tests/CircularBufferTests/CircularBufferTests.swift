import XCTest
@testable import CircularBuffer

final class CircularBufferTests: XCTestCase {
    func testFixedSize() throws {
        var buffer = CircularBuffer<Int>(capacity: 3)
        buffer.append(1)
        buffer.append(2)
        buffer.append(3)
        buffer.append(4)
        XCTAssertEqual(buffer.count, 3)
        XCTAssertEqual(buffer[0], 2)
        XCTAssertEqual(buffer[1], 3)
        XCTAssertEqual(buffer[2], 4)
    }
}
