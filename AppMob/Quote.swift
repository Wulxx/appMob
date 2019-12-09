//
//  Quote.swift
//  AppMob
//
//  Created by Yoan Delvaux on 26/11/2019.
//  Copyright © 2019 Yoan Delvaux. All rights reserved.
//

import Foundation

struct Quote {
    var text: String
    var author: String
    var imageData: Data
}

struct DefQuote : Codable {
    var quoteText : String
    var quoteAuthor : String
    var senderName : String
    var senderLink : String
    var quoteLink : String
}
