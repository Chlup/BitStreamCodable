//
//  MyData.swift
//  BitStreamCodableDev
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation
import BitStreamCodableDevFramework

enum MyTypes: Int {
    case Asset = 20
    case MyData = 21
}

struct Asset {
    let assetID: Int
}

extension Asset: BitStreamIdentifiable {
    static var bitStreamIdentifier: Int { MyTypes.Asset.rawValue }
}

extension Asset: BitStreamCodable {
    func encode(with encoder: BitStreamEncoder) {
        encoder.encode(assetID)
    }

    init(with decoder: BitStreamDecoder) throws {
        self.assetID = try decoder.decode(Int.self)
    }
}

struct MyData {
    let value: Int
    //    var data: [String: Any]
    let asset: Asset
}

extension MyData: BitStreamIdentifiable {
    static var bitStreamIdentifier: Int { MyTypes.MyData.rawValue }
}


extension MyData: BitStreamCodable {

    func encode(with encoder: BitStreamEncoder) {
        encoder.encode(value)
        //        encoder.encode(data.compactMapValues { $0 as? Element })
        encoder.encode(asset)
    }

    init(with decoder: BitStreamDecoder) throws {
        let value = try decoder.decode(Int.self)
        //        //        let data = try decoder.decodeDictionary()
        let asset = try decoder.decode(Asset.self)
        
        self.init(value: value, asset: asset)
    }
}
