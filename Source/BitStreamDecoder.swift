//
//  BitStreamDecoder.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

public class BitStreamDecoder {

    let protocolVersion: BitStreamProtocolVersion
    var readType: Bool = true

    init(protocolVersion: BitStreamProtocolVersion) {
        self.protocolVersion = protocolVersion
    }

    public func decode<T: BitStreamDecodable>(_ valueType: T.Type) throws -> T {
        throw "Must be implemented in child class."
    }

    func decode<T: BitStreamDecodable>(_ valueType: T.Type, readType: Bool) throws -> T {
        throw "Must be implemented in child class."
    }

    
    func read(bytesCount: Int) throws -> [UInt8] {
        throw "Must be implemented in child class."
    }

    func read(bitsCount: UInt8) throws -> UInt8 {
        throw "Must be implemented in child class."
    }
//
//    func decodeInt(readType: Bool) throws -> Int {
//        throw "Must be implemented in child class."
//    }
//
//    func decodeData(readType: Bool) throws -> Data {
//        throw "Must be implemented in child class."
//    }
//
//    func decodeArray(readType: Bool) throws -> Array<BitStreamDecodable> {
//        throw "Must be implemented in child class."
//    }
}
