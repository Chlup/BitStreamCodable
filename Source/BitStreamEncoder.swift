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


public class BitStreamEncoder {

    private(set) var data = Data()
    private var buffer: UInt8 = 0
    private var freeBitsInBuffer: UInt8 = 8

    let protocolVersion: BitStreamProtocolVersion

    var writeType: Bool = true

    init(protocolVersion: BitStreamProtocolVersion) {
        self.protocolVersion = protocolVersion
    }

    public func encode<T: BitStreamEncodable>(_ value: T) {
        value.encode(with: self)
    }
}

extension BitStreamEncoder {

    func start() {
        data.append(contentsOf: protocolVersion.octets())
    }

    func finish() {
        print("Finish")
        buffer <<= freeBitsInBuffer
        writeBuffer()
    }

    func write(bytes: [UInt8]) {
        bytes.forEach { self.write(byte: $0, useBitsCount: 8)}
    }

    func write(byte: UInt8, useBitsCount: UInt8) {
        print("Writing byte \(byte.binaryDescription) usingBits count: \(useBitsCount)")
        print("buffer \(buffer.binaryDescription) freeBitsInBuffer \(freeBitsInBuffer)")

        if useBitsCount > freeBitsInBuffer {
            print("useBitsCount > freeBitsInBuffer")
            buffer <<= freeBitsInBuffer
            let remainingBitsToStore = useBitsCount - freeBitsInBuffer
            buffer |= byte >> remainingBitsToStore
            writeBuffer()

            print("After > write buffer \(buffer.binaryDescription) freeBitsInBuffer \(freeBitsInBuffer) remainingBitsToStore \(remainingBitsToStore)")

            buffer |= (byte & ~(UInt8.max << remainingBitsToStore))
            freeBitsInBuffer -= remainingBitsToStore

        } else if useBitsCount == freeBitsInBuffer {
            print("useBitsCount == freeBitsInBuffer")
            buffer <<= freeBitsInBuffer
            buffer |= byte
            freeBitsInBuffer = 0

        } else {
            print("useBitsCount < freeBitsInBuffer")
            buffer <<= useBitsCount
            buffer |= byte
            freeBitsInBuffer -= useBitsCount
        }

        print("Buffer after write buffer \(buffer.binaryDescription) freeBitsInBuffer \(freeBitsInBuffer)")

        if freeBitsInBuffer == 0 {
            writeBuffer()
        }
    }

    func writeBuffer() {
        print("Writing buffer \(buffer.binaryDescription)")
        data.append(buffer)
        buffer = 0
        freeBitsInBuffer = 8
    }
}
