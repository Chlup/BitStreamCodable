//
//  BitStreamData.swift
//  BitStreamCoder
//
//  Created by Michal Fousek on 10.05.2021.
//

import Foundation

class BitStreamData {
    let data: Data
    var offset = 0

    init(data: Data) {
        self.data = data
    }

    func get(bytesCount count: Int) throws -> Data {
        guard data.count >= offset + count else {
            throw "Data out of bounds \(offset) \(count). SimpleDecoder"
        }

        defer { offset += count }
        return data.subdata(in: offset..<(offset + count))
    }
}
