//
//  String+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension String: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        let data = try decoder.decode(Data.self)
        guard let string = String(data: data, encoding: .utf8) else { throw "Can't decode string" }
        self = string
    }
}
