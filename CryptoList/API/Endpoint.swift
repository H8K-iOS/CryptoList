//
//  Endpoint.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 07/10/23.
//

import Foundation


enum Endpoint {
    
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    //  case postCoins(url: String = "/v1/postCoin")
    
    //MARK: - URL request
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    //MARK: - URL settings
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem]{
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "USD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
            
        }
    }
    
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        }
    }
    
    
    private var httpBody: Data? {
        switch self {
            
        case .fetchCoins:
            return nil
        }
    }
}

//MARK: - Extension for URLRequest
extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
            
        }
        
    }
    
}

//MARK: - if we add 1 more case or more
/*
 
 private var path: String {
 switch self {
 case .fetchCoins(let url), .case(), .case(),
 .postCoins(let url):
 return url
 }
 }
 
 */
