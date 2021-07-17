//
//  Prototype.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 07.05.2021.
//

import Foundation

extension String: Error { }

protocol Element {
    static var type: UInt16 { get }
    func encode(with encoder: SimpleEncoder)
    static func decode(with decoder: SimpleDecoder) throws -> Self
}

extension Int: Element {
    static var type: UInt16 { 3 }
    func encode(with encoder: SimpleEncoder) {
        encoder.encode(self)
    }

    static func decode(with decoder: SimpleDecoder) throws -> Self {
        return try decoder.decodeInt()
    }
}

extension Data: Element {
    static var type: UInt16 { 2 }
    func encode(with encoder: SimpleEncoder) {
        encoder.encode(self)
    }

    static func decode(with decoder: SimpleDecoder) throws -> Self {
        return try decoder.decodeData()
    }
}

struct Asset {
    let assetID: Int
}

extension Asset: Element {
    static var type: UInt16 { 1 }
    func encode(with encoder: SimpleEncoder) {
        encoder.encode(assetID)
    }

    static func decode(with decoder: SimpleDecoder) throws -> Self {
        return Asset(assetID: try decoder.decodeInt())
    }
}

struct MyData {
    let value: Int
//    var data: [String: Any]
    let asset: Asset
}

extension MyData: Element {
    static var type: UInt16 { 5 }

    func encode(with encoder: SimpleEncoder) {
        encoder.encode(value)
//        encoder.encode(data.compactMapValues { $0 as? Element })
        encoder.encode(asset)
    }

    static func decode(with decoder: SimpleDecoder) throws -> Self {
        let value = try decoder.decodeInt()
//        let data = try decoder.decodeDictionary()
        let asset = try decoder.decodeElement(Asset.self)
        return MyData(value: value, asset: asset)
    }
}

class SimpleEncoder {
    var data = Data()

    func encode(_ value: Element) {
        data.append(contentsOf: type(of: value).type.bytes())
        value.encode(with: self)
    }

    func encode(_ value: Int) {
        self.data.append(contentsOf: Int.type.bytes())
        self.data.append(contentsOf: value.bytes())
    }

    func encode(_ value: Data) {
        self.data.append(contentsOf: Data.type.bytes())
        self.data.append(contentsOf: value.count.bytes())
        self.data.append(value)
    }

    func encode(_ value: [String: Element]) {

    }
}

class SimpleDecoder {
    let data: Data
    var offset = 0
    init(data: Data) {
        self.data = data
    }

    func get(bytesCount count: Int, from data: Data) throws -> Data {
        guard data.count >= offset + count else {
            throw "Data out of bounds \(offset) \(count). SimpleDecoder"
        }

        defer { offset += count }
        return data.subdata(in: offset..<(offset + count))
    }

    func skipType() {
        offset += 2
    }

    func decodeElement<T: Element>(_ elementType: T.Type) throws -> T {
        // read type for element we don't need it here.
        _ = try get(bytesCount: 2, from: data)
        return try elementType.decode(with: self)
    }

    func decodeInt() throws -> Int {
        _ = try get(bytesCount: 2, from: data)
        return try get(bytesCount: 8, from: data).decodeInt()
    }

    func decodeData() throws -> Data {
        _ = try get(bytesCount: 2, from: data)
        let length = try get(bytesCount: 8, from: data).decodeInt()
        return try get(bytesCount: length, from: data)
    }

    func decodeDictionary() throws -> [String: Element] {
        return [:]
    }
}

class Decoder {

    let data: Data
    let registeredTypes: [UInt16: Element.Type]
    let basicTypes: [UInt16] = [3, 2]

    var version: UInt8 = 0
    var typeLength: UInt8 = 0

    var offset: Int = 0

    init(data: Data, registeredTypes: [UInt16: Element.Type]) {
        self.data = data
        self.registeredTypes = registeredTypes
    }

    func get(bytesCount count: Int, from data: Data) throws -> Data {
        guard data.count >= offset + count else {
            throw "Data out of bounds \(offset) \(count). Decoder"
        }

        defer { offset += count }
        return data.subdata(in: offset..<(offset + count))
    }

    func load() throws {
        version = try get(bytesCount: 1, from: data).decodeUInt8()
        typeLength = try get(bytesCount: 1, from: data).decodeUInt8()
    }

    func decode() throws -> Element {
        let type = try get(bytesCount: 2, from: data).decodeUInt16()
//        offset -= 2
        guard let elementType = registeredTypes[type] else { throw "Root type not recognized" }
        let decoder = SimpleDecoder(data: try get(bytesCount: data.count - offset, from: data))
        return try elementType.decode(with: decoder)
    }
}

class Engine {

    var registeredTypes: [UInt16: Element.Type] = [:]
    var basicTypes: [UInt16] = [3, 2]

    init() { }

    public func register(elementType: Element.Type) {
        assert(registeredTypes[elementType.type] == nil, "Type \(elementType) is already registered.")
        registeredTypes[elementType.type] = elementType
    }

    func encode(value: Element) -> Data {
        var data = Data()
        data.append(contentsOf: [UInt8(1)])
        data.append(contentsOf: [UInt8(16)])

        let encoder = SimpleEncoder()
        encoder.encode(value)

        data.append(encoder.data)

        return data
    }

    func decode(data: Data) -> Decoder {
        return Decoder(data: data, registeredTypes: registeredTypes)
    }
}

struct Test {
    func run() {
        let engine = Engine()
        engine.register(elementType: Int.self)
    }
}
