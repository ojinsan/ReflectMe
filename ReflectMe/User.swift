//
//  User.swift
//  ReflectMe
//
//  Created by Fauzan Ramadhan on 09/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import Foundation


struct User:Codable {
    var username: String
    var dateJoined: String
    var badges: [String]
}
