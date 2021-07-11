//
//  NetworkService.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//

import Foundation
import Combine

class NetworkService {
    
    let apiClient: APIClient
    let baseUrl: URL
    var urlPath: String?
    var parameters: [String: String]?
    
    init(host: BaseUrlHost) {
        self.apiClient = APIClient()
        self.baseUrl = URL(string: host.rawValue)!
    }
    
    func setupRequest(path: String, params: [String: String]? = nil) {
        self.urlPath = path
        self.parameters = params
    }
    
    func performRequest() -> AnyPublisher<RmResponse, Error> {
        guard let path = urlPath, var urlComps = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true) else {  fatalError("URLComps problem") }
        if let params = parameters {
            urlComps.queryItems = []
            params.forEach {
                let queryItem = URLQueryItem(name: $0.key, value: $0.value)
                urlComps.queryItems?.append(queryItem)
            }
        }
        return execute(URLRequest(url: urlComps.url!))
    }
    
    private func execute(_ request: URLRequest) -> AnyPublisher<RmResponse, Error> {
        return apiClient.executeRequest(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
