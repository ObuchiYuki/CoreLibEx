//
//  Ex+Range.swift
//  CoreUtil
//
//  Created by yuki on 2021/11/02.
//  Copyright © 2021 yuki. All rights reserved.
//

extension Range {
    public static func formRange(_ bound1: Bound, _ bound2: Bound) -> Range {
        bound1 <= bound2 ? bound1..<bound2 : bound2..<bound1
    }
}

extension ClosedRange {
    public static func formRange(_ bound1: Bound, _ bound2: Bound) -> ClosedRange {
        bound1 <= bound2 ? bound1...bound2 : bound2...bound1
    }
    
    public static func formRange(_ bound1: Bound, _ bound2: Bound) -> ClosedRange where Bound: FloatingPoint {
        guard bound1.isFinite, bound2.isFinite else { return 0...0 }
        return bound1 <= bound2 ? bound1...bound2 : bound2...bound1
    }
}
