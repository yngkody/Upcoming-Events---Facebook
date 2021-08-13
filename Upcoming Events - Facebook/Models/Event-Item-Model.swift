//
//  Event-Item-Model.swift
//  Upcoming Events - Facebook
//
//  Created by Kody Young on 8/12/21.
//

import Foundation


struct EventModelItem: Decodable, Hashable {
    var title: String
    var start: String
    var end: String
}
