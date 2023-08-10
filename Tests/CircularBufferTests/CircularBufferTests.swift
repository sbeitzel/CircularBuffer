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

    func testContains() throws {
        var buffer = CircularBuffer<Int>(capacity: 5)
        for number in 1..<6 { buffer.append(number) }
        for number in 1..<6 {
            XCTAssertTrue(buffer.contains(where: { $0 == number }))
        }
    }

    func testIterator() throws {
        var buffer = CircularBuffer<Int>(capacity: 3)
        buffer.append(1)
        buffer.append(2)
        buffer.append(3)
        buffer.append(4)
        var elements = ""
        for number in buffer {
            elements += "\(number)"
        }
        XCTAssertEqual(elements, "234")
    }
}
