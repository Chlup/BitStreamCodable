//
//  Optional+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Optional: BitStreamDecodable where Wrapped: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding optional")
        let isNil = try decoder.read(bitsCount: 1) == 0
        if isNil {
            self = .none
        } else {
            self = .some(try Wrapped(with: decoder))
        }
    }
}
