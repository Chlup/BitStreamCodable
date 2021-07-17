//
//  Data+decode.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

public extension Data {

    func octets() -> [UInt8] {
        return Array(self)
    }

    func decodeInteger<T: FixedWidthInteger>() throws -> T {
        let bytesCount = MemoryLayout<T>.size
        let octets = self.octets()
        guard octets.count == bytesCount else { throw "Invalid number of octets" }

        var  value: T = 0
        for octet in octets {
            value <<= 8
            value |= T(octet)
        }
        return value

    }
}
