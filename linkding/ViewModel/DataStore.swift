//
//  DataStore.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import Foundation
import SwiftUI
import Combine

/// Gets and stores News data from the API.
///
class DataStore: ObservableObject {

    /// News data from the API is stored in this array at runtime.
    @Published private(set) var bookmarks: [Bookmark] = []

    /// The article that the users has selected to be displayed in full detail.
    //@Published var currentArticle: Bookmark = Bookmark
    
    private var networkManager: any NetworkLayer

    /// The News data is also stored on UserDefaults.
    private var userDefaults = UserDefaults.standard

    private var cancellables = Set<AnyCancellable>()

    private let apiDomain: String = "bookmarks.rpod.club"
    private let apiEndPoint: String = "/api/bookmarks/"

    /// Returns the assembled URLComponents of the API endpoint.
    lazy private var newsUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiDomain
        components.path = apiEndPoint
        return components
    }()

    /// Unwraps the URL, there's no fallback since the URL is hardcoded.
    lazy private var newsUrl: URL = {
        guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
        return unwrappedUrl
    }()

    init(_ networkManager: some NetworkLayer) {
        self.networkManager = networkManager
        ///  Loads the news from UserDefaults, if any, to ensure that the app always shows the latest fetched information when loaded.
        ///  Loads the news from UserDefaults, if any, to ensure that the app always shows the latest fetched information when loaded.
        if userDefaults.object(forKey: "bookmarks") != nil {
            bookmarks = getStoredNews(userDefaults.object(forKey: "bookmarks") as! Data)
        }

        /// Loads/updates the news from the internet.
        getNews()
    }

    /// Gets News data from the internet and decodes it. Then it sorts it by date and stores it on memory and on UserDefaults.
    private func getNews() {
        networkManager.getData(url: newsUrl)
            .decode(type: JsonBookmarks.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (articles) in
                /*
                let sortedArticles = self?.bookmarks

                if self?.bookmarks != sortedArticles {
                    self?.storeNews(sortedArticles)
                }*/
                print(articles.results)
                self?.bookmarks = articles.results
            }
            .store(in: &cancellables)
    }

    /// Returns News data from the UserDefaults.
    private func getStoredNews(_ data: Data) -> [Bookmark] {
        guard let decodedNews = try? JSONDecoder().decode([Bookmark].self, from: data) else {return []}
        return decodedNews
    }

    /// Saves News data to the UserDefaults.
    private func storeNews(_ news: [Bookmark]) {
        guard let encodedNews = try? JSONEncoder().encode(news) else {return}
        self.userDefaults.set(encodedNews, forKey: "bookmarks")
    }
}
