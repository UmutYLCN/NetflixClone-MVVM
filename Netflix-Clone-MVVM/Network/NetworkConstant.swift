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
            return "?api_key=7ca92030df8569b3253960ab36183fa4"
        }
    }
    
    public var Youtube_APIKey : String {
        get {
            return "&key=AIzaSyCoOyGpjsaUvb1HcVZ9cx_TaJD5tv9b7g4"
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
