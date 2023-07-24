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

class Api : ObservableObject {
    
    @Published var books = [Bookmark]()
    @Published var searchText: String = ""
    @Published var status: Status = Status.loading
    
    private var apiDomain: String = ""
    private var apiToken: String = ""
    private var apiEndPoint: String = "/api/bookmarks/"
        
    private var headers = ["Authorization": "Token <TOKEN>"]
    
    func setProperty(domain: String, token: String){
        objectWillChange.send()
        self.apiToken = token
        self.apiDomain = domain
        self.headers = ["Authorization": "Token \(self.apiToken)"]
    }
    
    func resetBooksList(){
        objectWillChange.send()
        self.books = [Bookmark]()
        self.newsUrlComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = self.apiDomain
            components.path = self.apiEndPoint
            return components
        }()
        self.compileUrl = {
            guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
            return unwrappedUrl
        }()
    }

    func reloadData(){
        resetBooksList()
        if !apiDomain.isEmpty && !apiToken.isEmpty {
            loadData { (loaded_bookmarks) in
                self.books = loaded_bookmarks
            }
        } else {
            self.status = Status.error
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
        components.host = self.apiDomain
        components.path = self.apiEndPoint
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
        self.status = Status.loading
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                DispatchQueue.main.async {
                    self.status = Status.error
                }
                return
            }
             
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
