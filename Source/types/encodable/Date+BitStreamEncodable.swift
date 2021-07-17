//
//  Date+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension Date: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        encoder.encode(timeIntervalSince1970)
    }
}
