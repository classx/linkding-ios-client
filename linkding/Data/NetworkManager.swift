//
//  NetworkManager.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import Foundation
import Combine

/// Manages network calls with combine.
/// It's responsible for getting any kind of data from an URL.
///
class NetworkManager: NetworkLayer {
    let headers = ["Authorization": "Token 91327d880c0fb9619831b8cd282aa5843e8a4419"]

    private enum DataError: Error {
        case cantDecode
        case badResponse(response: URLResponse, url: URL)
    }

    /// Gets data from an URL, retries three times in case of network errors.
    func getData(url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                try self.checkResponse(dataTaskOutput: $0, url: url)
            }
            .retry(3)
            .eraseToAnyPublisher()
    }

    ////  Returns the data from the network call if there are no errors in the response.
    private func checkResponse(dataTaskOutput: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
            guard let response = dataTaskOutput.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                throw DataError.badResponse(response: dataTaskOutput.response, url: url)
            }
            return dataTaskOutput.data
        }
}
