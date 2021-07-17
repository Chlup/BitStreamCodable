//
//  Array+BitStreamCodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 12.05.2021.
//

import Foundation

//extension Array: BitStreamEncodable where Element: BitStreamEncodable {
//    public func encode(with encoder: BitStreamEncoder) {
//        encode(with: encoder, writeType: true)
//    }
//}
//
//extension Array: BitStreamEncodableInternal where Element: BitStreamEncodable {
//    func encode(with encoder: BitStreamEncoder, writeType: Bool) {
//        if writeType {
//            encoder.write(byte: BitStreamDefaultType.Array.rawValue, useBitsCount: encoder.typeBitsCount)
//        }
//
//        encoder.encode(count, writeType: false)
//        forEach { encoder.encode($0, writeType: true) }
//    }
//}
