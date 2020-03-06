//
//  APIClient.swift
//  CocoaPodsLab
//
//  Created by Eric Davenport on 3/6/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
  static func fetchUser(completion: @escaping (AFResult<[User]>) -> ()) {
    let endpointString = "https://randomuser.me/api/?results=50"
    
    guard let url = URL(string: endpointString) else {
      return
    }
    
    AF.request(url).response { (response) in
      if let error = response.error {
        completion(.failure(error))
      } else if let data = response.data {
        do {
          let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
          let users = results.results
          completion(.success(users))
        } catch {
          completion(.failure(.sessionTaskFailed(error: error)))
        }
      }
      
    }
  }
  
  
}
