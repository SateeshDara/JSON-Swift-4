//
//  HomeFeed.swift
//  Separation_Concern
//
//  Created by Sateesh Dara on 08/09/18.
//  Copyright © 2018 Sateesh Dara. All rights reserved.
//

import Foundation

struct HomeFeed: Decodable {
    let videos: [Video]
}

struct Video: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}
