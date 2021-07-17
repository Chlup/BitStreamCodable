//
//  Data+BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension Data: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding Data")
        encoder.encode(count)
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
