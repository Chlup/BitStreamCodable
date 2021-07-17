//
//  Int+BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension Int: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding int")
        if decoder.readType {
            let type = try decoder.read(bitsCount: Constants.typeBitsCount)
            print("type \(type)")
        }
        let octetsCount = try decoder.read(bitsCount: 3)
        print("bytes count \(octetsCount)")
        let octets = try decoder.read(bytesCount: Int(octetsCount + 1))
        print("bytes \(octets)")

        let decodedValue: Int = octets.decodeInteger()
        self = decodedValue.zigZagDecode()
    }
}
