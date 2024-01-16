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
    
    private let cacheManager = RMAPICacheManager()
    
    private init(){}
    
    enum RMServiceError: Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// api call
    /// - Parameters:
    ///   - request: Request instance
    ///   -type: type of object we expect to get back
    ///   - completion: callback void, data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>)->Void
    ){
        if let cachedData = cacheManager.cachedResponse(
            for: request.endpoint,
            url: request.url){
            print("cached api response")
            do{
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequset = self.request(from: request)else{
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequset){ [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            //decode response
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data)
                completion(.success(result))
            } catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    private func request(from rmRequest: RMRequest)-> URLRequest?{
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMEthod
        return request
    }
    

}
