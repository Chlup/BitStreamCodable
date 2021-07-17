//
//  String+BitStreamEncodable.swift
//  BitStreamCodableDevFramework
//
//  Created by Michal Fousek on 17.07.2021.
//

import Foundation

extension String: BitStreamEncodable {
    public func encode(with encoder: BitStreamEncoder) {
        encoder.encode(Data(self.utf8))
    }
}
