//
//  Encodable+Utility.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self)
        else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any]}
    }
}
