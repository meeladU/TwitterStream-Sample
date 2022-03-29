//
//  RequestHandler.swift
//  TwitterStream-Sample
//

import Foundation

/// `RequestHandler` handles the result of the request

class RequestHandler {

    /**
        Handles the response data of the request
     
        - parameter completion: The closure called when the `Data` conversionn  into model  is completed
     
        - returns: A closure which takes one argument: Result enum
    */

    func networkResult<T: Decodable> (
        completion: @escaping ((Result<T, TSError>) -> Void)
    ) -> ((Result<Data, TSError>) -> Void) {
        return { dataResult in
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    let dataString = String(decoding: data, as: UTF8.self)
                    let decoder = JSONDecoder()
                    print("data string: \(dataString)")
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.parser(string: "Parsing the data error: " + error.localizedDescription)))
                    }

                case .failure(let error) :
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                }
            })
        }
    }
}
