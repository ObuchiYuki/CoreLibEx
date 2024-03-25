//
//  Ex+CaseIterable.swift
//  CoreUtil
//
//  Created by yuki on 2020/10/13.
//  Copyright © 2020 yuki. All rights reserved.
//

extension CaseIterable where Self: Hashable {
    public static func `case`(_ index: Int) -> Self { Self.allCases.map { $0 }[index] }
    
    public var index: Int {
        Self.allCases.map{ $0 }.firstIndex(of: self)!
    }
}
