//
//  Ex+String.swift
//  CoreUtil
//
//  Created by yuki on 2020/09/30.
//  Copyright © 2020 yuki. All rights reserved.
//

extension String {
    @inlinable public static func random(length: Int = 10, base: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        String((0..<length).map {_ in base.randomElement()!})
    }
}

