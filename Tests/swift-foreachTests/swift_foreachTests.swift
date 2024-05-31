import XCTest
@testable import swift_foreach

final class swift_foreachTests: XCTestCase {
    func testPerformance_forEach() throws {
        let random = RandomUInt8Sequence(count: 1_000_000)
        var count = 0
        measure {
            random.forEach { _ in
                count += 1
            }
        }
        XCTAssertEqual(count, 1_000_000 * 10)
    }
    func testPerformance_forIn() throws {
        let random = RandomUInt8Sequence(count: 1_000_000)
        var count = 0
        measure {
            for _ in random {
                count += 1
            }
        }
        XCTAssertEqual(count, 1_000_000 * 10)
    }
}
