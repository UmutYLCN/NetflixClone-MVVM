//
//  APICaller.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 13.09.2023.
//

import Foundation

enum NetworkError : Error {
    case urlError
    case canNotParseData
}


class APICaller {
    
    static let shared = APICaller()
    
    //MARK: Trending Movies
    func getTrendingMovies(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)trending/movie/day\(NetworkConstant.shared.apiKey)&language=en-US&page=1") else  {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    //MARK: Trending Tv
    func getTrendingTvs(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)trending/tv/day\(NetworkConstant.shared.apiKey)&language=en-US&page=1") else  {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    //MARK: Upcoming
    func getUpcomingMovies(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)movie/upcoming\(NetworkConstant.shared.apiKey)&language=en-US&page=1") else  {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    //MARK: Populer
    func getPopuler(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)movie/popular\(NetworkConstant.shared.apiKey)&language=en-US&page=1") else  {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    
    //MARK: Top Rated
    func getTopRated(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)movie/top_rated\(NetworkConstant.shared.apiKey)&language=en-US&page=1") else  {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    
    
    //MARK: Discover Movies
    
    func getDiscoverMovies(completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)discover/movie\(NetworkConstant.shared.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    
    
    //MARK: Search Tmdp
    
    func search(with query: String, completion : @escaping (Result<[Title], NetworkError >) -> Void ){
        
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(NetworkConstant.shared.serverAddress)search/movie\(NetworkConstant.shared.apiKey)&query=\(query)") else {return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    
    //MARK: Search YoutubeAPI
    
    func YoutubeSearch(with query: String, completion : @escaping (Result<VideoElement, NetworkError >) -> Void ){
        
        //https://youtube.googleapis.com/youtube/v3/search?q=Harry
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(NetworkConstant.shared.YoutubeServerAddress)?q=\(query)\(NetworkConstant.shared.Youtube_APIKey)") else {return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch {
                completion(.failure(NetworkError.canNotParseData))
            }
            
            
        }
        task.resume()
    }
    
    
    
}
