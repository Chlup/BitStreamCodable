//
//  BitStream.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

extension String: Error { }

enum Constants {
    static let typeBitsCount: BitStreamTypeLength = 5
}

enum BitStreamDefaultType: UInt8, CaseIterable {
    case Int = 0
    case Int8 = 1
    case Int16 = 2
    case Int32 = 3
    case Int64 = 4
    case UInt8 = 5
    case UInt16 = 6
    case UInt32 = 7
    case UInt64 = 8
    case Float = 9
    case Double = 10
    case Bool = 11
    case String = 12
    case Date = 13
    case Data = 14
    case Array = 15
    case Dictionary = 16
    case Optional = 17
}

public typealias BitStreamTypeLength = UInt8
public typealias BitStreamProtocolVersion = UInt16

public struct BitStream {

    public static var currentProtocolVersion: BitStreamProtocolVersion { 1 }

    public init() { }

    public func encode<T: BitStreamEncodable>(_ value: T) -> Data {
        let encoder = BitStreamEncoder(protocolVersion: BitStream.currentProtocolVersion)
        encoder.start()
        encoder.encode(value)
        encoder.finish()
        return encoder.data
    }

    public func decode<T: BitStreamDecodable>(_ type: T.Type, from data: Data) throws -> T  {
        let decoder = BitStreamBasicDecoder(data: data)
        try decoder.load()
        print("Version: \(decoder.version)")
        return try decoder.decode(type)
    }
}
