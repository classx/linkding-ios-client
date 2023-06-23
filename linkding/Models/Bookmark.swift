//
//  News.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import Foundation

/// The data model of the application.
///
struct Bookmark: Codable, Identifiable, Equatable {

    let id: Int
    let url: String
    let title: String
    let description: String?
    let notes: String?
    let website_title: String?
    let website_description: String?
    let is_archived: Bool
    let unread: Bool
    let shared: Bool
    
    let tag_names: [String]?
    let date_added: String
    let date_modified: String

    /// Returns the Date from the  'release_date' String.
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"

        if let date: Date = formatter.date(from: self.date_modified) {
            return date
        } else {
            return Date.distantPast
        }
    }

    /// Returns the Date in the required format.
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, ''yy"
        return formatter.string(from: self.date).capitalized
    }
}

struct JsonBookmarks: Codable, Equatable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Bookmark]
}
