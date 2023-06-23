//
//  NetworkLayer.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import Foundation
import Combine

protocol NetworkLayer {
    func getData(url: URL) -> AnyPublisher<Data, Error>
}
