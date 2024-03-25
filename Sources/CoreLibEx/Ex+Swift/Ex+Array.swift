//
//  Extensions.swift
//  DANMAKER
//
//  Created by yuki on 2015/06/24.
//  Copyright © 2015 yuki. All rights reserved.
//

extension Sequence {
    @inlinable public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        try self.lazy.filter(condition).count
    }
    
    @inlinable public func minIndex(by condition: (Element, Element) -> Bool) -> Int? {
        self.enumerated().min(by: { condition($0.element, $1.element) })?.offset
    }

    @inlinable public func maxIndex(by condition: (Element, Element) -> Bool) -> Int? {
        self.enumerated().max(by: { condition($0.element, $1.element) })?.offset
    }
    
    @inlinable public func firstSome<T>(where condition: (Element) throws -> T?) rethrows -> T? {
        try self.lazy.compactMap(condition).first
    }
    
    @inlinable public func compactAllSatisfy<T>(_ tranceform: (Element) -> T?) -> [T]? {
        var storage = [T]()
        
        for element in self {
            guard let value = tranceform(element) else { return nil }
            storage.append(value)
        }
        return storage
    }
    
    @inlinable public func uniqued<Key: Hashable>(by predicate: (Element) -> (Key)) -> [Element] {
        var set = Set<Key>()
        var result = [Element]()
        for element in self {
            let key = predicate(element)
            if set.contains(key) { continue }
            set.insert(key)
            result.append(element)
        }
        return result
    }
    
    @inlinable public func uniqued() -> [Element] where Element: Hashable {
        self.uniqued(by: { $0 })
    }

    @inlinable public func allIndex(matching condition: (Element) -> Bool) -> [Int] {
        var result = [Int]()
        for (i, elm) in self.enumerated() {
            if condition(elm) { result.append(i) }
        }
        return result
    }
    
    @inlinable public func allEqual(to target: Element, by predicate: (Element, Element) -> Bool) -> Bool {
        var buffer: Element = target
        var iterator = self.makeIterator()
        
        while let cursor = iterator.next() {
            if !predicate(buffer, cursor) { return false }
            buffer = cursor
        }
        
        return true
    }
    
    @inlinable public func allEqual(to target: Element) -> Bool where Element: Equatable {
        self.allEqual(to: target, by: ==)
    }
    
    @inlinable public func allEqual(by predicate: (Element, Element) -> Bool) -> Bool {
        var iterator = self.makeIterator()
        guard var buffer = iterator.next() else { return true }
        
        while let cursor = iterator.next() {
            if !predicate(buffer, cursor) { return false }
            buffer = cursor
        }
        
        return true
    }
    
    @inlinable public func allEqual() -> Bool where Element: Equatable {
        self.allEqual(by: ==)
    }
    
    @inlinable public func max(_ replace: Element) -> Element where Element: Comparable {
        self.max() ?? replace
    }
    
    @inlinable public func min(_ replace: Element) -> Element where Element: Comparable {
        self.min() ?? replace
    }
    
    @inlinable public func minIndex() -> Int? where Element: Comparable {
        self.enumerated().min(by: { $0.element < $1.element })?.offset
    }

    @inlinable public func maxIndex() -> Int? where Element: Comparable {
        self.enumerated().max(by: { $0.element < $1.element })?.offset
    }
}

extension Array {
    @inlinable public func duplications() -> Set<Element> where Element: Hashable {
        var set = Set<Element>()
        var result = Set<Element>()
        
        for element in self {
            if set.contains(element) {
                result.insert(element)
            }else{
                set.insert(element)
            }
        }
        
        return result
    }
    
    @inlinable public func at(_ index: Self.Index) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
    
    @inlinable public mutating func move(fromIndex: Int, toIndex: Int) {
        assert(self.indices.contains(fromIndex), "fromIndex '\(fromIndex)' is out of bounds.")
        
        if fromIndex == toIndex { return }
        let removed = self.remove(at: fromIndex)
        
        if fromIndex < toIndex {
            self.insert(removed, at: toIndex - 1)
        } else {
            self.insert(removed, at: toIndex)
        }
    }
    
    @inlinable public mutating func move<Range: RangeExpression>(fromRange: Range, toIndex: Int) where Range.Bound == Int {
        assert(self.indices.contains(toIndex), "toIndex '\(toIndex)' is out of bounds.")
        let range = fromRange.relative(to: self)
        
        if range.contains(toIndex) { return }
        
        let removed = self[range]
        self.removeSubrange(range)
        
        if range.upperBound < toIndex + range.count - 1 {
            self.insert(contentsOf: removed, at: toIndex - range.count + 1)
        } else {
            self.insert(contentsOf: removed, at: toIndex)
        }
    }

    @discardableResult
    @inlinable public mutating func removeFirst(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for i in 0..<self.count {
            if try condition(self[i]) { return remove(at: i) }
        }
        return nil
    }
    
    @discardableResult
    @inlinable public mutating func popFront() -> Element? {
        guard !self.isEmpty else { return nil }
        return self.remove(at: 0)
    }
}
