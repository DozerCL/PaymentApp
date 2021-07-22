//
//  RequestExecutor.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 20-07-21.
//

import Foundation
import Alamofire
import RxSwift

public protocol RequestExecutor {
    func execute<Request: HttpRequest, Response: Codable>(request: Request) -> Single<Response>
}

public final class RequestExecutorImpl: RequestExecutor {
    public func execute<Request: HttpRequest, Response: Codable>(request: Request) -> Single<Response> {
        let path = Configuration.baseUrl + request.path
        let method = request.method
        
        return Single<Response>.create(subscribe: { observer in
            let url = URL(string: path)!
            let method = HTTPMethod(rawValue: method)
            let urlRequest = try! URLRequest(url: url, method: method)
            
            let request = Session.default.request(urlRequest)
                .responseData(completionHandler: { response in
                    switch response.result {
                    case let .success(value):
                        let decoder = JSONDecoder()
                        if let decodedResponse = try? decoder.decode(Response.self, from: value) {
                            observer(.success(decodedResponse))
                        } else {
                            observer(.failure(NSError(domain: "Decoding error", code: 0, userInfo: nil)))
                        }
                    case let .failure(error):
                        observer(.failure(error))
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
