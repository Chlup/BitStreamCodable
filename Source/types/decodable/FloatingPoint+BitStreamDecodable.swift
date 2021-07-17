//
//  Float+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension FloatingPoint where Self: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        let octetsCount = MemoryLayout<Self>.size
        let octets = try decoder.read(bytesCount: octetsCount)
        self = try Data(octets).decodeFloatingPoint()
    }
}

extension Float: BitStreamDecodable { }
extension Float16: BitStreamDecodable { }
extension Float80: BitStreamDecodable { }
extension Double: BitStreamDecodable { }
