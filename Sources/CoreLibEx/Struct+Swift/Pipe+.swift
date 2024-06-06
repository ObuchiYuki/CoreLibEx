//
//  +Functions.swift
//  CoreUtil
//
//  Created by yuki on 2020/10/01.
//  Copyright © 2020 yuki. All rights reserved.
//

precedencegroup PipePrecedence {
    higherThan: NilCoalescingPrecedence
    associativity: left
}

infix operator  =>: PipePrecedence
infix operator &=> : PipePrecedence
infix operator  |>: PipePrecedence
infix operator &|>: PipePrecedence

@inlinable @_transparent @inline(__always)
@discardableResult
public func => <T>(lhs: T, rhs: (T) throws -> Void) rethrows -> T {
    try rhs(lhs)
    return lhs
}

@inlinable @_transparent @inline(__always)
@discardableResult 
public func &=> <T>(lhs: inout T, rhs: (inout T) -> Void) -> T {
    rhs(&lhs)
    return lhs
}

@inlinable @_transparent @inline(__always)
@discardableResult 
public func &=> <T>(lhs: T, rhs: (inout T) -> Void) -> T {
    var lhs = lhs
    rhs(&lhs)
    return lhs
}

@inlinable @_transparent @inline(__always)
@discardableResult
public func |> <T, U>(lhs: T, rhs: (T) throws -> U) rethrows -> U {
    try rhs(lhs)
}

@inlinable @_transparent @inline(__always)
@discardableResult
public func &|> <T, U>(lhs: inout T, rhs: (inout T) throws -> U) rethrows -> U {
    try rhs(&lhs)
}

@inlinable @_transparent @inline(__always)
@discardableResult
public func &|> <T, U>(lhs: T, rhs: (inout T) throws -> U) rethrows -> U {
    var lhs = lhs
    return try rhs(&lhs)
}
