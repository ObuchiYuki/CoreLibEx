//
//  Zip+Sequence.swift
//  CoreUtil
//
//  Created by yuki on 2022/01/22.
//  Copyright © 2022 yuki. All rights reserved.
//

@inlinable public func zip<A: Sequence, B: Sequence, C: Sequence>(_ a: A, _ b: B, _ c: C) -> Zip3Sequence<A, B, C> {
    Zip3Sequence(a, b, c)
}

@inlinable public func zip<A: Sequence, B: Sequence, C: Sequence, D: Sequence>(_ a: A, _ b: B, _ c: C, _ d: D) -> Zip4Sequence<A, B, C, D> {
    Zip4Sequence(a, b, c, d)
}

@inlinable public func zip<A: Sequence, B: Sequence, C: Sequence, D: Sequence, E: Sequence>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> Zip5Sequence<A, B, C, D, E> {
    Zip5Sequence(a, b, c, d, e)
}

public struct Zip3Sequence<A: Sequence, B: Sequence, C: Sequence>: Sequence {
    public typealias Element = (A.Element, B.Element, C.Element)
    
    public let a: A
    public let b: B
    public let c: C
    
    public struct Iterator: IteratorProtocol {
        @usableFromInline var a: A.Iterator
        @usableFromInline var b: B.Iterator
        @usableFromInline var c: C.Iterator
        
        @usableFromInline init(a: A.Iterator, b: B.Iterator, c: C.Iterator) {
            self.a = a
            self.b = b
            self.c = c
        }
        
        @inlinable mutating public func next() -> Element? {
            if let a = a.next(), let b = b.next(), let c = c.next() { return (a, b, c) }
            return nil
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(a: a.makeIterator(), b: b.makeIterator(), c: c.makeIterator())
    }
    
    @inlinable init(_ a: A, _ b: B, _ c: C) {
        self.a = a
        self.b = b
        self.c = c
    }
}

public struct Zip4Sequence<A: Sequence, B: Sequence, C: Sequence, D: Sequence>: Sequence {
    public typealias Element = (A.Element, B.Element, C.Element, D.Element)
    
    public let a: A
    public let b: B
    public let c: C
    public let d: D
    
    public struct Iterator: IteratorProtocol {
        @usableFromInline var a: A.Iterator
        @usableFromInline var b: B.Iterator
        @usableFromInline var c: C.Iterator
        @usableFromInline var d: D.Iterator
        
        @usableFromInline init(a: A.Iterator, b: B.Iterator, c: C.Iterator, d: D.Iterator) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
        }
        
        @inlinable mutating public func next() -> Element? {
            if let a = a.next(), let b = b.next(), let c = c.next(), let d = d.next() { return (a, b, c, d) }
            return nil
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(a: a.makeIterator(), b: b.makeIterator(), c: c.makeIterator(), d: d.makeIterator())
    }
    
    @inlinable init(_ a: A, _ b: B, _ c: C, _ d: D) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
}

public struct Zip5Sequence<A: Sequence, B: Sequence, C: Sequence, D: Sequence, E: Sequence>: Sequence {
    public typealias Element = (A.Element, B.Element, C.Element, D.Element, E.Element)
    
    public let a: A
    public let b: B
    public let c: C
    public let d: D
    public let e: E
    
    public struct Iterator: IteratorProtocol {
        @usableFromInline var a: A.Iterator
        @usableFromInline var b: B.Iterator
        @usableFromInline var c: C.Iterator
        @usableFromInline var d: D.Iterator
        @usableFromInline var e: E.Iterator
        
        @usableFromInline init(a: A.Iterator, b: B.Iterator, c: C.Iterator, d: D.Iterator, e: E.Iterator) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
        }
        
        @inlinable mutating public func next() -> Element? {
            if let a = a.next(), let b = b.next(), let c = c.next(), let d = d.next(), let e = e.next() { return (a, b, c, d, e) }
            return nil
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(a: a.makeIterator(), b: b.makeIterator(), c: c.makeIterator(), d: d.makeIterator(), e: e.makeIterator())
    }
    
    @inlinable init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
    }
}
