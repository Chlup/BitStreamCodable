//
//  Date+BitStreamDecodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Date: BitStreamDecodable {
    public init(with decoder: BitStreamDecoder) throws {
        let timestamp = try decoder.decode(TimeInterval.self)
        self = Date(timeIntervalSince1970: timestamp)
    }
}
