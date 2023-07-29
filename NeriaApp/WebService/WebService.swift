//
//  WebService.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation
import Alamofire
import UIKit




struct WebService {
    // MARK: - property
    static let baseURLString: String = "https://rickandmortyapi.com/api"
    
    static func getRequest<T:Codable>(stringURL: String ,completion: @escaping(Result<T,ErrorResponse>) ->()){
        
        guard let url = URL(string: stringURL) else { return }
        AF.request(url).response { (result) in
            guard let data = result.data else{ return }
            guard let decodedData: T = try? JSONDecoder().decode(T.self, from: data) else { return }
            if result.response?.statusCode == 200 {
                completion(.success(decodedData))
            } else{
                if let error: ErrorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data){
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func loadImage(stringURL: String, completion: @escaping(Data?)->()) {
        
        guard let url = URL(string: stringURL) else { return }
        AF.request(url).responseData { (result) in
            if let imageData = result.data {
                completion(imageData)
            } else {
                completion(nil)
            }
        }
    }
}
