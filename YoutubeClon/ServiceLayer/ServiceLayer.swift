//
//  ServiceLayer.swift
//  YoutubeClon
//
//  Created by Marielsy on 13/03/22.
//Decodable, se encarga de la traduccion  de convertir ese objeto que llego en json a un formato que se este utilizando

import Foundation


import UIKit
import Foundation

 @MainActor
 class ServiceLayer{
    static func callService<T: Decodable>(_ requestModel: RequestModel, _ modelType: T.Type) async throws -> T{
    
//            Get query paramenters
            
    var serviceUrl =  URLComponents(string: requestModel.getURL())
    serviceUrl?.queryItems = buildQueryItems(params: requestModel.queryItems ?? [:])
    serviceUrl?.queryItems?.append(URLQueryItem(name: "Key", value : Constants.apiKey))
    
//    Unwrap URl
    guard let componentURL = serviceUrl?.url else{
    throw NetworkError.invalidURL
    
    }
    var request = URLRequest(url:componentURL)
    request.httpMethod = requestModel.httpMethod.rawValue
    
    do{
        let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else{
        throw NetworkError.httpResponseError
    }
    if (httpResponse.statusCode > 299){
    throw NetworkError.statusCodeError
    }
    let decoder = JSONDecoder()
    do{
            let decodeData = try decoder.decode(T.self, from: data)
                return decodeData
    }catch{
        print(error)
        throw NetworkError.couldNotDecodeData
        }
    }catch{
    throw NetworkError.generic
        }
    
    
    }
    static func buildQueryItems(params:[String:String])-> [URLQueryItem]{
        let items = params.map({URLQueryItem(name: $0, value: $1)})
        return items
        
        
    }
}
