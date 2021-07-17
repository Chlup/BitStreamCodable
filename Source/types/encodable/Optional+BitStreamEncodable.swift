//
//  Optional+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Optional: BitStreamEncodable where Wrapped: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        print("Encoding optional")
        switch self {
        case .some(let value):
            encoder.write(byte: 1, useBitsCount: 1)
            encoder.encode(value)

        case .none:
            encoder.write(byte: 0, useBitsCount: 1)
        }
    }
}
