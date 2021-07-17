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
import BitStreamCodableDevFramework

enum MyTypes: Int {
    case Asset = 20
    case MyData = 21
}

struct Asset {
    let assetID: Int
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
