//
//  Array+BitStreamCodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 12.05.2021.
//

import Foundation

extension Array: BitStreamDecodable where Element: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        print("Decoding Array")
        let elementsCount = try decoder.decode(Int.self)
        print("elements count \(elementsCount)")

        self = try (0..<elementsCount).map { _ in
            return try Element(with: decoder)
        }
    }
}
