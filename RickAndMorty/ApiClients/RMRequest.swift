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
    private let endpoint: RMEndpoint
    
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
    
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem]=[]) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest{
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
