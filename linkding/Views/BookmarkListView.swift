//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI
import Drops

struct BookmarkListView: View {
    let haptic = UINotificationFeedbackGenerator()

    @StateObject var bookmarks = Api()
    @State var presentSettingsSheet = false
    @State var presentAddFormSheet = false
    
    var body: some View {
        NavigationStack {
            Group {
                if (bookmarks.status == Status.success){
                    List {
                        ForEach(bookmarks.filteredBookmarks) { bookmark in
                           // NavigationLink(destination: BookmarkItemDetailView(item: bookmark)) {
                                BookmarkItemView(item: bookmark)
                            
                                .swipeActions(edge: .trailing){
                                    Button {
                                        openBookmartURL(url: bookmark.url)
                                    } label: {
                                        Label("Open in Safari", systemImage: "safari")
                                    }
                                    .tint(.indigo)
                                    
                                    Button(
                                        role: .destructive,
                                        action: {
                                            print("remove here")
                                            bookmarks.delete(item: bookmark)
                                        }
                                    ) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    
                                    ShareLink("Share", item: URL(string: bookmark.url)!)
                                    .tint(.yellow)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        CopyToClip(text: bookmark.url)
                                        self.haptic.notificationOccurred(.success)
                                        Drops.show(copyDrops())
                                    } label: {
                                        Label("Copy URL", systemImage: "doc.on.doc")
                                    }
                                    .tint(.blue)
                                }
                           // }
                        }
                    }
                    .searchable(text: $bookmarks.searchText)
                    .refreshable {
                        bookmarks.reloadData()
                    }
                    .listStyle(.plain)
                } else if (bookmarks.status == Status.error) {
                    LoadErrorView()
                } else {
                    LoadingView()
                }
            }
            .sheet(isPresented: $presentSettingsSheet) {
                print("Sheet dismissed!")
            } content: {
                SettingView()
            }
            .sheet(isPresented: $presentAddFormSheet) {
                print("Sheet dismissed!")
            } content: {
                AddBookmarkView()
            }
            .navigationTitle("Linkding")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Button(action: {
                    presentSettingsSheet.toggle()
                }) {
                    Image(systemName: "gearshape.2")
                }.accentColor(.black)
            )
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentAddFormSheet.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                
            )
            
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
