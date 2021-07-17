//
//  Bool+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Bool: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        encoder.write(byte: self ? 1 : 0, useBitsCount: 1)
    }
}
