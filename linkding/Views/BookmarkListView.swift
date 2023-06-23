//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct BookmarkListView: View {
    var data: [Bookmark]
    var body: some View {
        NavigationStack {
            List {
                LazyVStack {
                    ForEach(data) { bookmark in
                        Text(bookmark.title)
                    }
                }
            }
            .refreshable {
                print("refresh here")
            }
            .onAppear()
            .listStyle(.plain)
            .navigationTitle("Linkding")
        }
    }
}

//struct BookmarkListView_Previews: PreviewProvider {
//    static var previews: some View {
//        var b = Bookmark(id: 1, title: "test", description: "test", release_date: "test", author: "", image: "nil")
//        BookmarkListView(data: [b])
//    }
//}
