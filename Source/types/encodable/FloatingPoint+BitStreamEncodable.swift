//
//  Float+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension FloatingPoint where Self: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        encoder.write(bytes: octets())
    }
}

extension Float: BitStreamEncodable { }
extension Float16: BitStreamEncodable { }
extension Float80: BitStreamEncodable { }
extension Double: BitStreamEncodable { }
