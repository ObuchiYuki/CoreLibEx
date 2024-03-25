//
//  Mixture.swift
//  CoreUtil
//
//  Created by yuki on 2020/05/16.
//  Copyright © 2020 yuki. All rights reserved.
//

/// 混合値もしくは単一値を表す。
///
/// # 使い方
///
/// ```
/// let mixsedData = [1, 6, 9, 6, 9]
/// print(mixsedData.mixture) // .mixed
///
/// let singleValuesData = [3, 3, 3, 3]
/// print(singleValuesData.mixture) // .identical(3)
/// ```
public enum Mixture<Value> {
    case mixed
    case identical(Value)
}

extension Mixture: Hashable where Value: Hashable {
    @inlinable public func hash(into hasher: inout Hasher) {
        if case .identical(let value) = self {
            hasher.combine(value)
        }
    }
}

extension Mixture: Equatable where Value: Equatable {
    @inlinable public static func ?? (lhs: Mixture<Value>, rhs: Value) -> Value {
        lhs.reduce(mixed: rhs)
    }
    
    @inlinable public static func == (lhs: Mixture<Value>, rhs: Mixture<Value>) -> Bool {
        switch lhs {
        case .mixed:
            if case .mixed = rhs { return true }
            return false
        case .identical(let lvalue):
            if case .identical(let rvalue) = rhs, rvalue == lvalue { return true }
            return false
        }
    }
}

extension Mixture: CustomStringConvertible {
    @inlinable public var description: String {
        switch self {
        case .identical(let value): return "Mixture<\(Value.self)>.identical(\(value))"
        case .mixed: return "Mixture<\(Value.self)>.mixed"
        }
    }
}

extension Mixture {
    @inlinable public var isMixed: Bool {
        if case .mixed = self { return true }
        return false
    }
}

extension Mixture {
    /// 複数の`Mixture`の値を混合し結果をタプルの`Mixture`で返す。
    /// 1つでも`mixed`が存在したら `mixed`になる。
    @inlinable public func combine<Value2>(_ other: Mixture<Value2>) -> Mixture<(Value, Value2)> {
        switch (self, other) {
        case let (.identical(value1), .identical(value2)): return .identical((value1, value2))
        default: return .mixed
        }
    }

    /// 複数の`Mixture`の値を混合し結果をタプルの`Mixture`で返す。
    /// 1つでも`mixed`が存在したら `mixed`になる。
    @inlinable public func combine<Value2, Value3>(_ other2: Mixture<Value2>, _ other3: Mixture<Value3>) -> Mixture<(Value, Value2, Value3)> {
        switch (self, other2, other3) {
        case let (.identical(value1), .identical(value2), .identical(value3)): return .identical((value1, value2, value3))
        default: return .mixed
        }
    }
}

extension Mixture {
    @inlinable public func map<T>(_ tranceform: (Value) throws -> T) rethrows -> Mixture<T> {
        switch self {
        case .identical(let value):
            return .identical(try tranceform(value))
        case .mixed:
            return .mixed
        }
    }

    @inlinable public func flatMap<T>(_ tranceform: (Value) throws -> Mixture<T>) rethrows -> Mixture<T> {
        switch self {
        case .identical(let value):
            switch try tranceform(value) {
            case .identical(let value): return .identical(value)
            case .mixed: return .mixed
            }
        case .mixed: return .mixed
        }
    }

    /// `identity`の場合と`mixed`の場合をまとめて1つの値にして返す。
    @inlinable public func reduce(mixed: @autoclosure () throws -> Value) rethrows -> Value {
        switch self {
        case .identical(let value): return value
        case .mixed: return try mixed()
        }
    }
    
    @inlinable public func reduceNil() -> Value? {
        map{ .some($0) }.reduce(mixed: nil)
    }
    
    @inlinable public func reduceNil<T>() -> Value where Value == Optional<T> {
        map{ $0 }.reduce(mixed: nil)
    }
}

extension RandomAccessCollection where Self.Index == Int {
    @inlinable public func mixture(_ condition: (Element, Element) -> (Bool)) -> Mixture<Element?> {
        if self.isEmpty { return .identical(nil) }
        if self.count == 1 { return .identical(self[0]) }

        for i in 0..<self.count-1 {
            if !condition(self[i], self[i+1]) { return .mixed }
        }

        return .identical(self[0])
    }
    
    @inlinable public func mixture(_ replace: Element, _ condition: (Element, Element) -> Bool) -> Mixture<Element> {
        mixture(condition).map{ $0 ?? replace }
    }
}

extension RandomAccessCollection where Element: Equatable, Self.Index == Int {
    @inlinable public var mixture: Mixture<Element?> {
        mixture(==)
    }

    @inlinable public func mixture(_ replace: Element) -> Mixture<Element> {
        mixture(replace, ==)
    }
}
