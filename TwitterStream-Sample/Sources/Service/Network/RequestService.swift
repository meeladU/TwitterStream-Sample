//
//  RequestService.swift
//  TwitterStream-Sample
//

import Foundation

enum StreamError: Error {
    case noInternetConnection
}
/// Closure alias
typealias ResponseClosure = (RequestService.StreamResult) -> Void

/// `RequestService` is a concrete service class for requesting data from the server

final class RequestService: NSObject {
    
    private var responseClosure: ResponseClosure?
    enum StreamResult {
        case task(Data)
        case finished(Error?)
        case timeout
        case canceled
    }
    let dispatchQueue = DispatchQueue(label: "com.twitterstream.background", attributes: [])
    private(set) lazy var session: Foundation.URLSession = {
        let operationQueue = OperationQueue()
        operationQueue.underlyingQueue = self.dispatchQueue
        let configuration = URLSessionConfiguration.default
        return Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
    }()

    /**
     Creates an `URLSessionTask` with the specified url string and session.
     
     - parameter request:    URLRequest that will be used to request data from server
     - parameter session:     URLSession which will be used to create URLDataTask
     - parameter completion:  A closure to be executed once the task finishes. This closure takes one argument: the server response as TSResult enum
     
     - Returns: URLSessionTask object
     */

    func loadData(
        request: URLRequest,
        session: URLSession = URLSession(configuration: .default),
        completion: @escaping (Result<Data, TSError>) -> Void
    ) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error: \(error)")
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }

            if let data = data {
                print("Data: \(data)")
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }

    func connect(
        request: URLRequest,
        completion: @escaping ResponseClosure
    ) -> URLSessionTask {
        responseClosure = completion
        let task = session.dataTask(with: request)
        task.resume()
        return task
    }
}

extension RequestService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        let sameHost = task.originalRequest?.url?.host == challenge.protectionSpace.host
        let isAuthMethod = challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust

        guard let serverTrust = challenge.protectionSpace.serverTrust,
            sameHost && isAuthMethod else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if dataTask.state != .canceling {
            self.responseClosure?(.task(data))
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            responseClosure?(.finished(nil))
            return
        }
        switch error.code {
        case -1001: // Timeout
            responseClosure?(.timeout)
        case -999: // Canceled
            responseClosure?(.canceled)
        case -1009, -1005: // Lost network connection
            responseClosure?(.finished(StreamError.noInternetConnection))
        default:
            responseClosure?(.finished(error))
        }
    }
}
