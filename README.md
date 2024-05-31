# Swift forEach vs for-in

This repository is made to show some edge cases where `forEach` is better than `for ... in` in terms of performance.

To check performance, try the test. In the test code, there are two simple tests;

```swift

func testPerformance_forEach() throws {
    let random = RandomUInt8Sequence(count: 1_000_000)
    var count = 0
    measure {
        random.forEach { _ in
            count += 1
        }
    }
}

func testPerformance_forIn() throws {
    let random = RandomUInt8Sequence(count: 1_000_000)
    var count = 0
    measure {
        for _ in random {
            count += 1
        }
    }
}
```

For normal sequences these two codes works mostly in the same speed. However, because the implementation of `forEach` in `RandomUInt8Sequence` is special, `forEach` performs 5x faster than `for ... in` in the test as follows.

```
$ swift test -c release

Building for production...
[5/5] Linking swift-foreachPackageTests
Build complete! (0.75s)
Test Suite 'All tests' started at 2024-06-01 00:40:02.816.
Test Suite 'swift-foreachPackageTests.xctest' started at 2024-06-01 00:40:02.817.
Test Suite 'swift_foreachTests' started at 2024-06-01 00:40:02.817.
Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forEach]' started.
swift-foreach/Tests/swift-foreachTests/swift_foreachTests.swift:8: Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forEach]' measured [Time, seconds] average: 0.008, relative standard deviation: 62.348%, values: [0.023342, 0.011465, 0.008703, 0.005896, 0.006538, 0.005232, 0.005412, 0.005375, 0.006408, 0.006325], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , polarity: prefers smaller, maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forEach]' passed (0.381 seconds).
Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forIn]' started.
swift-foreach/Tests/swift-foreachTests/swift_foreachTests.swift:18: Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forIn]' measured [Time, seconds] average: 0.041, relative standard deviation: 20.214%, values: [0.062800, 0.038211, 0.036936, 0.036743, 0.036901, 0.036774, 0.036894, 0.036328, 0.051231, 0.039921], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , polarity: prefers smaller, maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
Test Case '-[swift_foreachTests.swift_foreachTests testPerformance_forIn]' passed (0.666 seconds).
Test Suite 'swift_foreachTests' passed at 2024-06-01 00:40:03.864.
	 Executed 2 tests, with 0 failures (0 unexpected) in 1.047 (1.047) seconds
Test Suite 'swift-foreachPackageTests.xctest' passed at 2024-06-01 00:40:03.864.
	 Executed 2 tests, with 0 failures (0 unexpected) in 1.047 (1.047) seconds
Test Suite 'All tests' passed at 2024-06-01 00:40:03.864.
	 Executed 2 tests, with 0 failures (0 unexpected) in 1.047 (1.049) seconds
```

