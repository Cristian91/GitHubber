//
//  NetworkClient.swift
//  GitHubber
//
//  Created by Cristi on 16/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

// we can define new requests by conforming to the Endpoint protocol
protocol Endpoint {
    var basePath: String {get}
    var path: String? {get}
    var method: HTTPMethod {get}
}

enum Repo: Endpoint
{
    // use an associated value to keep the number of repos we want to retrieve
    case getRepositories(numberOfRepositories:Int)
    // I defined this case too even though I eventually didn't use it
    case getImageFromUrlString(urlString:String)
    
    // specify the base path of the intended method; usually it would be a common basePath, but for downloading the image we would have an entire path
    public var basePath: String {
        switch self {
        case .getRepositories(_): return "https://api.github.com/"
        case .getImageFromUrlString(let urlString): return urlString
        }
    }
    
    // specify the path we want the request to be made
    public var path: String? {
        switch self {
        case .getRepositories(_): return "search/repositories"
        case .getImageFromUrlString(_): return nil
        }
    }
    
    // return .get for all requests
    public var method: HTTPMethod {
        return .get
    }
}


final class HomeNetworkClient {
    var sessionManager = Alamofire.SessionManager.default
    
    func request(for endpoint: Repo, completion: @escaping (Result<Any>) -> ()) {
        // we can define this as implicitly unwrapped since basePath is a requirement from Endpoint protocol, so the string can't be empty
        var url = URL(string: endpoint.basePath)!
        
        switch endpoint {
        case .getRepositories(let number):
            sessionManager = Alamofire.SessionManager.default
            // we can use the HomeRequestAdapter to adapt the request before sending it;
            sessionManager.adapter = HomeRequestAdapter(numberOfEntries: number)
            if let appendingPath = endpoint.path {
                url.appendPathComponent(appendingPath)
            }
            sessionManager.request(url, method: endpoint.method).responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(Result.success(data))
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
            
        // initially, I wanted to use AlamofireImage to download images and store them into the model from HomeViewModel, but that would have implied to update the model and refresh the table view (or maybe there are other powers of AlamofireImage which I am now aware of), and then I turned on the SDWebImage since this could be achieved using a single line of code
        case .getImageFromUrlString(let imagePath):
            sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: imagePath))
            sessionManager.request(url, method: endpoint.method).responseImage { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(Result.success(data))
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
            break
        }
    }
}

// I used this adapter for the .getRepositories call, as I find it very powerful and convenient to adapt a request before it is sent
final class HomeRequestAdapter: RequestAdapter {
    let entries: Int
    
    init(numberOfEntries entries: Int) {
        self.entries = entries
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        // pass in the query items in a safe manner and fallback to original request if something failed
        if let urlString = urlRequest.url?.absoluteString {
            let parameters: [String:String] = [
                "q":"RxSwift",
                "per_page":"\(entries)",
                "order":"desc"
            ]
            
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            if let url = urlComponents?.url {
                return URLRequest(url: url)
            }
        }
        
        return urlRequest
    }
}
