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
import XCTest
import Nimble
@testable import BitStreamCodableDevFramework

class OptionalEncodingDecodingTests: TestCase {

    func test__encodeOptional__withValue__rightFormatIsUsed() {
        let optional: UInt8? = 3
        let encoded = bitStream.encode(optional)
        expect(Array(encoded)) == [0, 1, 128, 24]
    }

    func test__encodeOptional__nil__rightFormatIsUsed() {
        let optional: UInt8? = nil
        let encoded = bitStream.encode(optional)
        expect(Array(encoded)) == [0, 1, 0]
    }

    func test__encodeAndDecodeOptional__withValue__decodedRight() {
        let optional: String? = "Hello world"
        let encoded = bitStream.encode(optional)
        let decoded = try! bitStream.decode(String?.self, from: encoded)
        expect(decoded) == "Hello world"
    }

    func test__encodeAndDecodeOptional__nil__decodedRight() {
        let optional: String? = nil
        let encoded = bitStream.encode(optional)
        let decoded = try! bitStream.decode(String?.self, from: encoded)
        expect(decoded).to(beNil())
    }
}
