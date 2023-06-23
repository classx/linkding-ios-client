//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct BookmarkListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("1")
                Text("1")
                Text("1")
                Text("1")
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

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
