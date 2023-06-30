//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct BookmarkListView: View {
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
                                .onTapGesture {}
                                .contextMenu {
                                    Group {
                                        Button {
                                            print("copy")
                                        } label: {
                                            Label("Copy URL", systemImage: "doc.on.doc")
                                        }
                                        Button {
                                            print("share")
                                        } label: {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                        Button {
                                            openBookmartURL(url: bookmark.url)
                                        } label: {
                                            Label("Open in Safari", systemImage: "safari")
                                        }
                                        Divider()
                                        Button {
                                            print("delete")
                                        } label: {
                                            Label("Delete", systemImage: "delete.left")
                                        }
                                    }
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
                }
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
