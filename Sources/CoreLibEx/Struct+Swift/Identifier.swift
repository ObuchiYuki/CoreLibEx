//
//  Identifier.swift
//  CoreUtil
//
//  Created by yuki on 2021/04/29.
//  Copyright © 2021 yuki. All rights reserved.
//

public enum Identifier<Value> {
    @inlinable public static func make(with rule: Identifier<Value>.Rule, on container: inout Set<Value>) -> Value where Value: Hashable {
        let id = make(with: rule) { !container.contains($0) }
        container.insert(id)
        return id
    }
    
    @inlinable public static func make(with rule: Identifier<Value>.Rule, notContainsIn set: Set<Value>) -> Value where Value: Hashable {
        let id = make(with: rule) { !set.contains($0) }
        return id
    }
    
    @inlinable public static func make(with rule: Identifier<Value>.Rule, _ condition: (Value) -> Bool) -> Value {
        var identifier: Value
        repeat {
            identifier = rule.next()
        } while !condition(identifier)
        return identifier
    }
    
    public struct Rule {
        @usableFromInline let next: () -> Value
        
        @inlinable public init(_ next: @escaping () -> Value) {
            self.next = next
        }
    }
}

extension Identifier.Rule where Value == Int {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == UInt {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == UInt8 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Int8 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == UInt16 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Int16 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == UInt32 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Int32 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == UInt64 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Int64 {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Float {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

extension Identifier.Rule where Value == Double {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

#if canImport(Foundation)
import Foundation

extension Identifier.Rule where Value == CGFloat {
    @inlinable public static func random(in range: ClosedRange<Value>) -> Identifier.Rule {
        Identifier.Rule { .random(in: range) }
    }
}

#endif

extension Identifier.Rule where Value == String {
#if canImport(Foundation)
    @inlinable public static func uuid() -> Identifier.Rule {
        Identifier.Rule { UUID().uuidString }
    }
#endif
    
    @inlinable public static func random(_ length: Int) -> Identifier.Rule {
        Identifier.Rule { .random(length: length) }
    }
    
    @inlinable public static func numberPostfix(_ base: String, separtor: String = " ") -> Identifier.Rule {
        var counter = 0
        return Identifier.Rule {
            defer { counter += 1 }
            return counter == 0 ? base : "\(base)\(separtor)\(counter)"
        }
    }
    
    @inlinable public static func brackedNumberPostfix(_ base: String, separtor: String = " ") -> Identifier.Rule {
        var counter = 0
        return Identifier.Rule {
            defer { counter += 1 }
            return counter == 0 ? base : base + "\(separtor)(\(counter))"
        }
    }
}

