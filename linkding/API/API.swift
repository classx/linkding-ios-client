//
//  API.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import Foundation
import SwiftUI
import Combine


enum Status {
    case success
    case loading
    case error
}

class Api : ObservableObject{
    
    @Published var books = [Bookmark]()
    @Published var searchText: String = ""
    @Published var status: Status = Status.loading
    
    private let apiDomain: String = "domain"
    private let apiEndPoint: String = "/api/bookmarks/"
        
    let headers = ["Authorization": "Token <TOKEN>"]
    
    init(){
        reloadData()
    }

    func reloadData(){
        self.status = Status.loading
        loadData { (loaded_bookmarks) in
            self.books = loaded_bookmarks
        }
    }
    
    var filteredBookmarks: [Bookmark] {
           guard !searchText.isEmpty else { return books }
           return books.filter { book in
               book.title.lowercased().contains(searchText.lowercased())
           }
       }
    
    lazy private var newsUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiDomain
        components.path = apiEndPoint
        return components
    }()
    /// Unwraps the URL, there's no fallback since the URL is hardcoded.
    lazy private var compileUrl: URL = {
        guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
        return unwrappedUrl
    }()
    
    func loadData(completion:@escaping ([Bookmark]) -> ()) {
        var request = URLRequest(url: compileUrl)
        request.httpMethod = "GET"
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let bookmarksList = try JSONDecoder().decode(JsonBookmarks.self, from: data!)
                DispatchQueue.main.async {
                    self.status = Status.success
                    completion(bookmarksList.results)
                }
            }catch {
                self.status = Status.error
            }
        }.resume()
    }

    func delete(item: Bookmark){
        lazy var deleteUrlItem: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = apiDomain
            components.path = "/api/bookmarks/\(item.id)/"
            return components
        }()
        /// Unwraps the URL, there's no fallback since the URL is hardcoded.
        lazy var deleteUrl: URL = {
            guard let unwrappedUrl = deleteUrlItem.url else { fatalError("Wrong URL") }
            return unwrappedUrl
        }()
        
        var request = URLRequest(url: deleteUrl)
        request.httpMethod = "DELETE"
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.deleteItem(item: item)
            }
        }.resume()
    }
    
    func deleteItem(item: Bookmark){
        self.books = self.books.filter { $0.id != item.id }
    }
    
}
