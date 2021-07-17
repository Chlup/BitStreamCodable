//
//  BitStreamDecoder.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

public class BitStreamDecoder {

    init() { }

    public func decode<T: BitStreamDecodable>(_ valueType: T.Type) throws -> T {
        throw "Must be implemented in child class."
    }
    
    func read(bytesCount: Int) throws -> [UInt8] {
        throw "Must be implemented in child class."
    }

    func read(bitsCount: UInt8) throws -> UInt8 {
        throw "Must be implemented in child class."
    }
}
