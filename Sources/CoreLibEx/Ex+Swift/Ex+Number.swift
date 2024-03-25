//
//  Ex+NUmber.swift
//  CoreUtil
//
//  Created by yuki on 2020/06/24.
//  Copyright © 2020 yuki. All rights reserved.
//

import Foundation

/// Returns `1` when the value greater than or equals to `0`. And returns `-1` when the value smaller than `0`
@inlinable public func sign<T: SignedNumeric & Comparable>(_ value: T) -> T {
    if value >= T.zero {
        return 1
    } else {
        return -1
    }
}

extension Double {
    @inlinable public func rounded(toDecimal fractionDigits: Int) -> Self {
        let multiplier = pow(10, Self(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

extension Float {
    @inlinable public func rounded(toDecimal fractionDigits: Int) -> Self {
        let multiplier = pow(10, Self(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

extension CGFloat {
    @inlinable public func rounded(toDecimal fractionDigits: Int) -> Self {
        let multiplier = pow(10, Self(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

extension CGRect {
    @inlinable public func nearyEqual(to value: CGRect, threshhold: CGFloat = 0.1) -> Bool {
        size.nearyEqual(to: size, threshhold: threshhold) && origin.nearyEqual(to: origin, threshhold: threshhold)
    }
}

extension CGSize {
    @inlinable public func nearyEqual(to value: CGSize, threshhold: CGFloat = 0.1) -> Bool {
        width.nearyEqual(to: value.width, threshhold: threshhold) && height.nearyEqual(to: value.height, threshhold: threshhold)
    }
}

extension CGPoint {
    @inlinable public func nearyEqual(to value: CGPoint, threshhold: CGFloat = 0.1) -> Bool {
        x.nearyEqual(to: value.x, threshhold: threshhold) && y.nearyEqual(to: value.y, threshhold: threshhold)
    }
}

extension FloatingPoint where Self: ExpressibleByFloatLiteral {
    @inlinable public func nearyEqual(to value: Self, threshhold: Self = 0.1) -> Bool {
        abs(self - value) < threshhold
    }
}
