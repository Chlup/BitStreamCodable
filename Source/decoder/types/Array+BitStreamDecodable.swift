//
//  Array+BitStreamCodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 12.05.2021.
//

import Foundation

extension Array: BitStreamDecodable where Element: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        try self.init(with: decoder, readType: true)
    }
}

extension Array: BitStreamDecodableInternal where Element: BitStreamDecodable {
    init(with decoder: BitStreamDecoder, readType: Bool) throws {
        throw "not implemented"
    }
}
