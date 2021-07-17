//
//  BitStreamCodable.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

public typealias BitStreamCodable = BitStreamEncodable & BitStreamDecodable

public protocol BitStreamIdentifiable {
    static var bitStreamIdentifier: Int { get }
}

private let _allInternalTypes: Set<Int> = Set(BitStreamDefaultType.allCases.map { Int($0.rawValue) })

extension BitStreamIdentifiable {
    static var isInternalType: Bool { _allInternalTypes.contains(Self.bitStreamIdentifier) }
}

public protocol BitStreamEncodable: BitStreamIdentifiable {
    func encode(with encoder: BitStreamEncoder)
}

public protocol BitStreamDecodable: BitStreamIdentifiable {
    init(with decoder: BitStreamDecoder) throws
}

