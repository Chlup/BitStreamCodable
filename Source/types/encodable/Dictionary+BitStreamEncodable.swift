//
//  Dictionary+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Dictionary: BitStreamEncodable where Key: BitStreamEncodable, Value: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding Dict")
        encoder.encode(count)
        for (key, value) in self {
            encoder.encode(key)
            encoder.encode(value)
        }
    }
}
