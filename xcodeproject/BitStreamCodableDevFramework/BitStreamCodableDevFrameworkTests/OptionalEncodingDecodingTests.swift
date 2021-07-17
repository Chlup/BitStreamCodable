//
//  OptionalEncodingDecodingTests.swift
//  BitStreamCodableDevFrameworkTests
//
//  Created by Michal Fousek on 17.07.2021.
//

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
