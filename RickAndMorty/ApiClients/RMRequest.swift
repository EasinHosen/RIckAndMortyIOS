//
//  RMRequeat.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 4/12/23.
//

import Foundation

/// Single api call
final class RMRequest{
    
    private struct Constants{
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    let endpoint: RMEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if(!pathComponents.isEmpty){
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        if(!queryParameters.isEmpty){
            string += "?"
            let argString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argString
        }
        
        return string
        
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMEthod = "GET"
    
    public init(endpoint: RMEndpoint, 
            pathComponents: [String] = [],
            queryParameters: [URLQueryItem]=[]) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    ///attempt to create request url to parse
    
    convenience init?(url: URL){
        let str = url.absoluteString
        if !str.contains(Constants.baseUrl){
            return nil
        }
        let trimed = str.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimed.contains("/"){
            let components = trimed.components(separatedBy: "/")
            if !components.isEmpty{
                let endpointStr = components[0]
                var pathComponents: [String] = []
                
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointStr) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        }else if trimed.contains("?"){
            let components = trimed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2{
                let endpointStr = components[0]
                let queryItemsStr = components[1]
                
                let queryItems: [URLQueryItem] = queryItemsStr.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else{
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointStr) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest{
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
}
