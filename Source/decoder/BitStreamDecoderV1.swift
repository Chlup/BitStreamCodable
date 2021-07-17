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


class BitStreamDecoderV1: BitStreamDecoder {
    let data: Data

    private var buffer: UInt8 = 0
    private var notReadBitsInBuffer: UInt8 = 8
    private var dataPointer: Int = 0

    init(data: BitStreamData, protocolVersion: BitStreamProtocolVersion) {
        self.data = data.data

        for byte in self.data {
            print("Byte \(byte.binaryDescription)")
        }

        super.init()
    }

    override func decode<T: BitStreamDecodable>(_ valueType: T.Type) throws -> T {
        return try valueType.init(with: self)
    }

    func prepare() throws {
    /// We have to skip first two bytes because version and type length is stored there.
        dataPointer = 1
        try readNextOctetIntoBuffer()
    }

    private func readNextOctetIntoBuffer() throws {
//        print("Reading buffer")
        guard dataPointer < data.count - 1 else {
            throw "Not enough bits to read"
            
        }
        dataPointer += 1
        buffer = data[dataPointer]
        notReadBitsInBuffer = 8
        print("read buffer \(buffer.binaryDescription)")
    }

    override func read(bytesCount: Int) throws -> [UInt8] {
        return try (0..<bytesCount).compactMap { _ in try self.read(bitsCount: 8) }
    }

    override func read(bitsCount: UInt8) throws -> UInt8 {
        assert(bitsCount > 0, "It doesn't make sense to read 0 bits.")
        assert(bitsCount <= 8, "If you wants to read more than 8 bits you probably wants to read whole bytes.")

        if notReadBitsInBuffer == 0 {
            try readNextOctetIntoBuffer()
        }

        print("Reading bitsCount \(bitsCount) buffer \(buffer.binaryDescription) notReadBitsInBuffer \(notReadBitsInBuffer)")

        var readBits: UInt8 = 0
        if bitsCount > notReadBitsInBuffer {
            print("bitsCount > notReadBitsInBuffer")
            let notReadBitsOnTheBegining = notReadBitsInBuffer
            let notInterestedBitsCount = 8 - notReadBitsOnTheBegining // bitsCount - notReadBitsInBuffer
            let maskForFirstBits = UInt8.max >> notInterestedBitsCount
            let bitsFromBuffer = buffer & maskForFirstBits
            try readNextOctetIntoBuffer()

//            print("Read buffer \(buffer.binaryDescription)")

            let maskForRestOfTheBits = UInt8.max << (8 - (bitsCount - notReadBitsOnTheBegining)) //(bitsCount - notInterestedBitsCount)
            let restOfBitsFromBuffer = buffer & maskForRestOfTheBits

            print("bitsCount > notReadBitsInBuffer")
            print("bitsFromBuffer \(bitsFromBuffer.binaryDescription) restOfBitsFromBuffer \(restOfBitsFromBuffer.binaryDescription)")

            readBits = (bitsFromBuffer << notInterestedBitsCount) | (restOfBitsFromBuffer >> (8 - notInterestedBitsCount))

            print("readBits \(readBits.binaryDescription)")

            notReadBitsInBuffer -= (bitsCount - notReadBitsOnTheBegining)

            // read 8 bits -> not enough in buffer, read last bit and put it to right 0000 0001
            //                load next octet
            //                shift previously read by 7 to left -> 1000 0000
            //                read 7 bits from new octet, shift-align them to right, add to previously read bit -> 1000 0101


        } else if bitsCount == notReadBitsInBuffer {
            print("bitsCount == notReadBitsInBuffer")
            let mask = (UInt8.max >> (8 - notReadBitsInBuffer))
            readBits = buffer & mask
            print("readBits \(readBits.binaryDescription)")
            notReadBitsInBuffer = 0

        } else {
            print("bitsCount < notReadBitsInBuffer")
            let mask = UInt8.max & (UInt8.max >> (8 - notReadBitsInBuffer)) & (UInt8.max << (notReadBitsInBuffer - bitsCount))
            readBits = (buffer & mask) >> (notReadBitsInBuffer - bitsCount)
            print("readBits \(readBits.binaryDescription)")
            notReadBitsInBuffer -= bitsCount
        }

        return readBits
    }
}
