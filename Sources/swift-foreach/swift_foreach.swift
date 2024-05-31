// The Swift Programming Language
// https://docs.swift.org/swift-book

struct RandomUInt8Sequence: Sequence {
    var count: Int
    init(count: Int) {
        self.count = count
    }
    func makeIterator() -> Iterator {
        Iterator(self)
    }
    
    struct Iterator: IteratorProtocol {
        private var count: Int
        private var current: Int = 0
        init(_ wrapped: RandomUInt8Sequence) {
            self.count = wrapped.count
        }
        mutating func next() -> UInt8? {
            guard current < count else {
                return nil
            }
            self.current += 1
            return UInt8.random(in: .min ... .max)
        }
        typealias Element = UInt8
    }

    @inlinable public func forEach(_ body: (Self.Element) throws -> Void) rethrows {
        print("Using special forEach")
        var i = 0
        while i + 8 < count {
            var rand = UInt64.random(in: .min ... .max)
            try withUnsafeBytes(of: &rand) { bytes in
                for byte in bytes {
                    try body(byte)
                }
            }
            i += 8
        }
        for _ in i ..< count {
            try body(UInt8.random(in: .min ... .max))
        }
    }
}
