//
//  Data+BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension Data: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding data")
        if decoder.readType {
            let type = try decoder.read(bitsCount: Constants.typeBitsCount)
            print("type \(type)")
        }

        let dataLength = try decoder.decode(Int.self, readType: false)

//        let dataLength = try decodeInt(readType: false)
        print("Data length: \(dataLength)")
        let data = try decoder.read(bytesCount: dataLength)

        self = Data(data)
//        _ = try data.get(bytesCount: 2)
//        let length = try data.get(bytesCount: 8).decodeInt()
//        return try data.get(bytesCount: length)
    }
}
