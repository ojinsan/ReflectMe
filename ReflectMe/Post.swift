//
//  Post.swift
//  ReflectMe
//
//  Created by Fauzan Ramadhan on 09/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import Foundation

struct Post:Codable {
    var postId: Int
    var postDate: Date
    var postEmotion:String
    var postDo: String
    var postThought: String
}


