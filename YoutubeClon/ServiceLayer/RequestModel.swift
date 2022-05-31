//
//  RequestModel.swift
//  YoutubeClon
//
//  Created by Marielsy on 13/03/22.
//

import Foundation

struct RequestModel {
    let endpoint : Endpoints
    var queryItems : [String:String]?
    let httpMethod : HttpMethod = .GET
    var basseUrl : URLBase = .youtube
    
    func getURL() -> String {
        return basseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod : String {
        case GET
        case POST
    }
    
    enum Endpoints : String {
        case search = "/search"
        case channels = "/channels"
        case playlists = "/playlists"
        case playlistItems = "/playlistItems"
        case empty = ""
    }
    
    enum URLBase: String {
        case youtube = "https://www.googleapis.com/youtube/v3/"
        case google = "https://otherweb.com/v2"

    }

}
