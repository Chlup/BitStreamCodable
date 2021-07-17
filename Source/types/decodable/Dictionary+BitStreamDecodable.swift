//
//  Dictionary+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Dictionary: BitStreamDecodable where Key: BitStreamDecodable, Value: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding Dict")
        let elementsCount = try decoder.decode(Int.self)
        print("elements count \(elementsCount)")

        let elements = try (0..<elementsCount).map { _ in
            return (try Key(with: decoder), try Value(with: decoder))
        }

        self = Dictionary(uniqueKeysWithValues: elements)
    }
}
