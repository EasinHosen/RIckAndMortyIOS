//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 10/1/24.
//

import Foundation


final class RMImageLoader{
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init(){}
    
    func downlaodImage(_ url: URL, completion: @escaping(Result<Data, Error>)-> Void){
        let key = url.absoluteString as NSString
        
        //returing cached data if exists
        if let data = imageDataCache.object(forKey: key){
//            print("reading from cache: \(key)")
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ [weak self]data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        task.resume()
    }
}
