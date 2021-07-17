//
//  BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

public typealias BitStreamCodable = BitStreamEncodable & BitStreamDecodable

public protocol BitStreamEncodable {
    func encode(with encoder: BitStreamEncoder)
}

public protocol BitStreamDecodable {
    init(with decoder: BitStreamDecoder) throws
}

