//
//  Ex+KeyPath.swift
//  CoreUtil
//
//  Created by yuki on 2020/11/11.
//  Copyright © 2020 yuki. All rights reserved.
//

extension Array {
    @inlinable public func min<T: Comparable>(by keyPath: (Element) -> T) -> Element? {
        self.min(by: { keyPath($0) < keyPath($1) })
    }

    @inlinable public func max<T: Comparable>(by keyPath: (Element) -> T) -> Element? {
        self.max(by: { keyPath($0) < keyPath($1) })
    }

    @inlinable public func sorted<T: Comparable>(by keyPath: (Element) -> T) -> [Element] {
        self.sorted(by: { keyPath($0) < keyPath($1) })
    }

    @inlinable public mutating func sort<T: Comparable>(by keyPath: (Element) -> T) {
        self.sort(by: { keyPath($0) < keyPath($1) })
    }

    @inlinable public func minIndex<T: Comparable>(by keyPath: (Element) -> T) -> Int? {
        self.minIndex(by: { keyPath($0) < keyPath($1) })
    }

    @inlinable public func maxIndex<T: Comparable>(by keyPath: (Element) -> T) -> Int? {
        self.maxIndex(by: { keyPath($0) < keyPath($1) })
    }
}
