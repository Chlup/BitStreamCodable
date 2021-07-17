//
//  FixedWidthInteger+Bytes.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 16.07.2021.
//

import Foundation

extension FixedWidthInteger {
    var bytesWidth: Int { bitWidth / 8 }

    func octets() -> [UInt8] {
        guard bitWidth > 8 else { return [UInt8(self)] }
        return stride(from: bitWidth - 8, to: -8, by: -8).map { return UInt8(self >> $0 & 0xFF) }
    }
}
