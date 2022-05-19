//
//  GenericGetData.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 1/10/22.
//  Copyright © 2022 Никита Ничепорук. All rights reserved.
//

import Foundation

protocol GetDataProtocol {
    func genericGetData<T: Decodable>(urlString: String, of_: T.Type, complition: @escaping (Result<T, Error>) -> ())
}

final class GetDataService {
    
}
// MARK: protocol extension
extension GetDataService: GetDataProtocol {
    func genericGetData<T>(urlString: String, of_: T.Type, complition: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let weatherJson: T = try JSONDecoder().decode(T.self, from: data)
                complition(.success(weatherJson))
            }
            catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
