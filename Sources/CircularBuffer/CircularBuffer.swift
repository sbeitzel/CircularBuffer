public struct CircularBuffer<Element>: Sequence {
    let capacity: Int
    var buffer: [Element]
    var insertionPoint: Int = 0
    
    public var count: Int {
        return buffer.count
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        buffer = [Element]()
    }
    
    public mutating func append(_ element: Element) {
        // are we going to evict an element?
        if buffer.count == capacity {
            buffer[insertionPoint] = element
        } else {
            buffer.append(element)
        }
        insertionPoint += 1
        if insertionPoint >= capacity {
            insertionPoint = 0
        }
    }
    
    public subscript(index: Int) -> Element {
        get {
            let realIndex = (insertionPoint + index) % capacity
            return buffer[realIndex]
        }
        set {
            let realIndex = (insertionPoint + index) % capacity
            buffer[realIndex] = newValue
        }
    }

    public func makeIterator() -> some IteratorProtocol<Element> {
        return CBIterator(self)
    }

    public struct CBIterator: IteratorProtocol {
        private let buffer: CircularBuffer
        private var nextIndex: Int

        init(_ buffer: CircularBuffer) {
            self.buffer = buffer
            self.nextIndex = 0
        }

        public mutating func next() -> Element? {
            if nextIndex > (buffer.count - 1) || nextIndex > (buffer.capacity - 1) {
                return nil
            } else {
                defer { nextIndex += 1 }
                return buffer[nextIndex]
            }
        }
    }
}
