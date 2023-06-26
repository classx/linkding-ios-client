//
//  ContentView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            BookmarkListView()
            .tabItem {
                    Label("Bookmarks", systemImage: "bookmark.circle")
            }
            AddBookmarkView()
            .tabItem {
                    Label("Add new", systemImage: "square.and.pencil")
            }
            SettingView()
            .tabItem {
                    Label("Setting", systemImage: "gearshape.2")
            }
       }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
