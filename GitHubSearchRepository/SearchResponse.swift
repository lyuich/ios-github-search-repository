//
//  SearchResponse.swift
//  GitHubSearchRepository
//
//  Created by lyuich on 4/14/17.
//  Copyright © 2017 lyuich. All rights reserved.
//

struct SearchResponse<Item: JSONDecodable> : JSONDecodable {
    let totalCount: Int
    let items: [Item]

    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeErorr.invalidFormat(json: json)
        }

        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecodeErorr.missingValue(key: "total_count", actualValue: dictionary["total_count"])
        }

        guard let itemObjects = dictionary["items"] as? [Any] else {
            throw JSONDecodeErorr.missingValue(key: "items", actualValue: dictionary["items"])
        }

        let items = try itemObjects.map {
            return try Item(json: $0)
        }

        self.totalCount = totalCount
        self.items = items
    }
}