public struct CircularBuffer<Element> {
  let capacity: Int
  var buffer: [Element]
  var insertionPoint: Int = 0

  var count: Int {
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

  subscript(index: Int) -> Element {
    get {
      let realIndex = (insertionPoint + index) % capacity
      return buffer[realIndex]
    }
    set {
      let realIndex = (insertionPoint + index) % capacity
      buffer[realIndex] = newValue
    }
  }

}
