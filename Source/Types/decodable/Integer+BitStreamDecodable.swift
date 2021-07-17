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

extension FixedWidthInteger where Self: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding int")

        let usingZigZag = try decoder.read(bitsCount: 1) == 1
        print("Using zig zag \(usingZigZag)")

        let octetsCount = try decoder.read(bitsCount: 3)
        print("bytes count \(octetsCount)")
        let octets = try decoder.read(bytesCount: Int(octetsCount + 1))
        print("bytes \(octets)")

        let decodedValue: Self = octets.decodeInteger()

        if usingZigZag {
            self = decodedValue.zigZagDecode()
        } else {
            self = decodedValue
        }

        print("Decoded \(self)")
    }
}

extension Int: BitStreamDecodable { }
extension Int16: BitStreamDecodable { }
extension Int32: BitStreamDecodable { }
extension Int64: BitStreamDecodable { }
extension UInt: BitStreamDecodable { }
extension UInt8: BitStreamDecodable { }
extension UInt16: BitStreamDecodable { }
extension UInt32: BitStreamDecodable { }
extension UInt64: BitStreamDecodable { }
