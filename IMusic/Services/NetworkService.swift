//
//  NetworkService.swift
//  IMusic
//
//  Created by Panchenko Oleg on 31.05.2022.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)",
                          "limit": "10",
                          "media": "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoder: .urlEncodedForm, headers: nil, interceptor: nil, requestModifier: nil).responseData { (dataResponse) in
            
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
//                print("objects: ", objects)
                completion(objects)
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
        }
    }
}
