//
//  Int+BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension Int: BitStreamIdentifiable {
    public static var bitStreamIdentifier: Int { Int(BitStreamDefaultType.Int.rawValue) }
}

extension Int: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        if encoder.writeType {
            encoder.write(byte: BitStreamDefaultType.Int.rawValue, useBitsCount: Constants.typeBitsCount)
        }

        let octets = self.zigZagEncode().octets()
        if let octetsFromIndex = octets.firstIndex(where: { $0 > 0 }) {

            // How many bytes do we use to store Int. We map <8...1> to <7...0> to use only 3 bits.
            encoder.write(byte: UInt8(octets.count - octetsFromIndex) - 1, useBitsCount: 3)

            // Now store the bytes.
            let octetsToEncode = Array(octets[octetsFromIndex..<octets.count])
            encoder.write(bytes: octetsToEncode)

        } else {
            // This can basically happen when Int is 0. We just store one zero byte.
            encoder.write(byte: 0, useBitsCount: 3)
            encoder.write(byte: 0, useBitsCount: 8)
        }

        //        self.data.append(contentsOf: Int.type.bytes())
        //        self.data.append(contentsOf: value.bytes())
    }
}

