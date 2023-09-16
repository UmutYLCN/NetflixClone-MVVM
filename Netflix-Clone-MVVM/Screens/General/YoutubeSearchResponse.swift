//
//  YoutubeSearchResponse.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 15.09.2023.
//

import Foundation

struct YoutubeSearchResponse : Codable {
    
    let items : [VideoElement]
}


struct VideoElement : Codable {
    let id : IdVideoElement
}

struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}
