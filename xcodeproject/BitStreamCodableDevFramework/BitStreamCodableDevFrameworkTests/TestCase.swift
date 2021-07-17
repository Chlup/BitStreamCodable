//
//  TestCase.swift
//  BitStreamCodableDevFrameworkTests
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation
import XCTest
@testable import BitStreamCodableDevFramework

class TestCase: XCTestCase {
    var bitStream: BitStream!

    override func setUp() {
        super.setUp()
        bitStream = BitStream()
    }

    override func tearDown() {
        super.tearDown()
        bitStream = nil
    }
}
