//
//  Int8+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 16.07.2021.
//

import Foundation

extension Int8: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding int8")

        if decoder.readType {
            let type = try decoder.read(bitsCount: Constants.typeBitsCount)
            print("type \(type)")
        }

        let octets = try decoder.read(bytesCount: 1)
        print("bytes \(octets)")

        var octet: Int8 = 0

        let pointer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.allocate(capacity: 1)
        pointer.pointee = octets[0]
        pointer.withMemoryRebound(to: Int8.self, capacity: 1) { octet = $0.pointee }
        pointer.deallocate()

        self = octet
    }
}

