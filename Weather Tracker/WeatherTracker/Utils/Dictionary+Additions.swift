//
//  Dictionary+Additions.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//

extension Dictionary where Key: Hashable {
    func appending(_ other: [Key: Value]) -> [Key: Value] {
        var mutableDictionary = self
        for (key, value) in other {
            mutableDictionary[key] = value
        }
        return mutableDictionary
    }
}
