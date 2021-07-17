//
//  BitStreamDecoder.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

class BitStreamBasicDecoder {
    let data: BitStreamData

    var version: BitStreamProtocolVersion = 0

    init(data: Data) {
        self.data = BitStreamData(data: data)
    }

    func load() throws {
        version = try data.get(bytesCount: 2).decodeInteger()
    }

    func decode<T: BitStreamDecodable>(_ type: T.Type) throws -> T {
        return try self.decoder(for: version).decode(type)
    }

    private func decoder(for version: BitStreamProtocolVersion) throws -> BitStreamDecoder {
        switch version {
        case 1:
            let decoder = BitStreamDecoderV1(data: data, protocolVersion: version)
            try decoder.prepare()
            return decoder

        default:
            throw "Unrecognized protocol version \(version)"
        }
    }
}
