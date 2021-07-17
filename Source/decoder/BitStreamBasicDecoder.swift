/*
MIT License

Copyright (c) 2021 Michal Fousek

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
