//
//  FixedWidthInteger+ZigZag.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 16.07.2021.
//

import Foundation

extension FixedWidthInteger {
    func zigZagEncode() -> Self {
        return (self >> (bitWidth - 1)) ^ (self << 1)
    }

    func zigZagDecode() -> Self {
        return (self >> 1) ^ (-1 * (self & 1))
    }
}
