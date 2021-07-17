//
//  Array+BitStreamCodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 12.05.2021.
//

import Foundation

extension Array: BitStreamEncodable where Element: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding Array")
        encoder.encode(count)
        forEach { encoder.encode($0) }
    }
}

