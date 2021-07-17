//
//  FloatPoint+Octets.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension FloatingPoint {
    func octets() -> [UInt8] {
        var value = self
        return withUnsafeBytes(of: &value, Array.init)
    }
}
