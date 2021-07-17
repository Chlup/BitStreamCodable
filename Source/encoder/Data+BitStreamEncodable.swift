//
//  Data+BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension Data: BitStreamIdentifiable {
    public static var bitStreamIdentifier: Int { Int(BitStreamDefaultType.Data.rawValue) }
}

extension Data: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        if encoder.writeType {
            encoder.write(byte: BitStreamDefaultType.Data.rawValue, useBitsCount: Constants.typeBitsCount)
        }
        encoder.encode(count, writeType: false)
        encoder.write(bytes: Array(self))
    }
}

//extension Data: BitStreamEncodableInternal {
//    public func encode(with encoder: BitStreamEncoder, writeType: Bool) {
//        if writeType {
//            encoder.write(byte: BitStreamDefaultType.Data.rawValue, useBitsCount: encoder.typeBitsCount)
//        }
//
//        encoder.encode(count, writeType: false)
//        encoder.write(bytes: Array(self))
//    }
//}
