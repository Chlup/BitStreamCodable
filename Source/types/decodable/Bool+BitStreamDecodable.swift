//
//  Bool+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Bool: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        self = try decoder.read(bitsCount: 1) == 1
    }
}
