//
//  Int8+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 16.07.2021.
//

import Foundation

extension Int8: BitStreamEncodable {

    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding UInt8")
        var octet: UInt8 = 0

        let pointer: UnsafeMutablePointer<Int8> = UnsafeMutablePointer.allocate(capacity: 1)
        pointer.pointee = self
        pointer.withMemoryRebound(to: UInt8.self, capacity: 1) { octet = $0.pointee }
        pointer.deallocate()

        encoder.write(byte: octet, useBitsCount: 8)
    }
}
