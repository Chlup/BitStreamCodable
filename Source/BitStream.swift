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

extension String: Error { }

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
