//
//  BytesArray+.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 11.05.2021.
//

import Foundation

extension Array where Element: FixedWidthInteger {
    func decodeInteger<T: FixedWidthInteger>() -> T {
        var value: T = 0

        for (index, octet) in reversed().enumerated() {
            value |= (T(octet) << (index * 8))
        }

        return value
    }
}
