//
//  Phase.swift
//  CoreUtil
//
//  Created by yuki on 2021/09/29.
//  Copyright © 2021 yuki. All rights reserved.
//

public enum Phase<Value> {
    case begin
    case changed(Value)
    case end
}

extension Phase where Value == Void {
    @inlinable public static var changed: Self {
        return .changed(())
    }
}

extension Phase {
    @inlinable public var value: Value? {
        switch self {
        case .changed(let value): return value
        default: return nil
        }
    }
}

extension Phase {
    @inlinable public func map<T>(_ tranceform: (Value) throws -> T) rethrows -> Phase<T> {
        switch self {
        case .begin: return .begin
        case .changed(let value): return try .changed(tranceform(value))
        case .end: return .end
        }
    }
}

