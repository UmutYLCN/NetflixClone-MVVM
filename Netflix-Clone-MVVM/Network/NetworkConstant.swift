//
//  NetworkConstant.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 13.09.2023.
//


import Foundation


class NetworkConstant {
    
    public static var shared : NetworkConstant = NetworkConstant()
    
    public var apiKey : String {
        get {
            return "api key"
        }
    }
    
    public var Youtube_APIKey : String {
        get {
            return "youtube api key"
        }
    }
    
    public var YoutubeServerAddress : String {
        get {
            return "https://youtube.googleapis.com/youtube/v3/search"
        }
    }
    
    public var serverAddress : String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    
    public var imageServerAddress : String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
    
    
}
