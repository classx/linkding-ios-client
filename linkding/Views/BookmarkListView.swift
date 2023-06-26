//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct BookmarkListView: View {
    @StateObject var bookmarks = Api()
    var body: some View {
        if (bookmarks.status == Status.success){
            NavigationStack {
                List {
                    ForEach(bookmarks.filteredBookmarks) { bookmark in
                        NavigationLink(destination: Text("You reached here via NaviagtionLink")) {
                            BookmarkItemView(item: bookmark)
                        }
                    }
                }
                .searchable(text: $bookmarks.searchText)
                .refreshable {
                    bookmarks.reloadData()
                }
                .listStyle(.plain)
                .navigationTitle("Linkding")
                
            }
        } else if (bookmarks.status == Status.error) {
            LoadErrorView()
        } else {
            LoadingView()
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
