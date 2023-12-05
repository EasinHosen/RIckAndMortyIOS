//
//  RMService.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 4/12/23.
//

import Foundation
///Primary API service obj
final class RMService{
    ///shared singletone
    static let shared = RMService()
    
    private init(){}
    
    /// api call
    /// - Parameters:
    ///   - request: Request instance
    ///   -type: type of object we expect to get back
    ///   - completion: callback void, data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>)->Void
    ){
        
    }
    
    

}
