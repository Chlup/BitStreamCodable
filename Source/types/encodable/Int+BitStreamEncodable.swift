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

extension Int: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding int \(self)")

        let valueToEncode: Int
        if self < 0 {
            print("Using zig zag")
            valueToEncode = self.zigZagEncode()
            encoder.write(byte: 1, useBitsCount: 1)
        } else {
            print("Not using zig zag")
            valueToEncode = self
            encoder.write(byte: 0, useBitsCount: 1)
        }

        let octets = valueToEncode.octets()

        if let octetsFromIndex = octets.firstIndex(where: { $0 > 0 }) {

            // How many bytes do we use to store Int. We map <8...1> to <7...0> to use only 3 bits.
            encoder.write(byte: UInt8(octets.count - octetsFromIndex) - 1, useBitsCount: 3)

            // Now store the bytes.
            let octetsToEncode = Array(octets[octetsFromIndex..<octets.count])
            encoder.write(bytes: octetsToEncode)

        } else {
            // This can basically happen when Int is 0. We just store one zero byte.
            encoder.write(byte: 0, useBitsCount: 3)
            encoder.write(byte: 0, useBitsCount: 8)
        }

        //        self.data.append(contentsOf: Int.type.bytes())
        //        self.data.append(contentsOf: value.bytes())
    }
}

