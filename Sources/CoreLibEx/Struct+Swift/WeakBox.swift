//
//  WeakBox.swift
//  CoreUtil
//
//  Created by yuki on 2021/05/23.
//  Copyright © 2021 yuki. All rights reserved.
//

public struct WeakBox<Value: AnyObject> {
    public weak var value: Value?
    
    @inlinable public init(_ value: Value?) { self.value = value }
}

public struct UnownedBox<Value: AnyObject> {
    public unowned var value: Value
    
    @inlinable public init(_ value: Value) { self.value = value }
}
