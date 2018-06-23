//
//  PartyRock.swift
//  Party Rock
//
//  Created by James Stafford on 2017-06-14.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

struct PartyRock {
    private var _imageURL: String
    private var _videoURL: String
    private var _videoTitle: String
    
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    init(imageURL: String, videoURL: String, videoTitle: String) {
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
    }
}
