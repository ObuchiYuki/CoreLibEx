//
//  Ex+Result.swift
//  CoreUtil
//
//  Created by yuki on 2021/06/19.
//  Copyright © 2021 yuki. All rights reserved.
//

extension Result {
    @inlinable public var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
    
    @inlinable public var isFailure: Bool {
        if case .failure = self { return true }
        return false
    }
    
    @inlinable public func takeSuccess() -> Success? {
        if case .success(let success) = self { return success }
        return nil
    }
    
    @inlinable public func takeFailure() -> Failure? {
        if case .failure(let failure) = self { return failure }
        return nil
    }
    
    @discardableResult 
    @inlinable public func sinkError(_ block: (Failure)->()) -> Success? {
        switch self {
        case .success(let success):
            return success
        case .failure(let failure):
            block(failure)
            return nil
        }
    }
    @discardableResult
    @inlinable public func sink(_ block: (Success)->()) -> Failure? {
        switch self {
        case .success(let success):
            block(success)
            return nil
        case .failure(let failure):
            return failure
        }
    }
}
