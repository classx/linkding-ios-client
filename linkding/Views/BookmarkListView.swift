//
//  BookmarkListView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI
import Drops

struct BookmarkListView: View {
    
    @EnvironmentObject var settings: AppSettings
    
    let haptic = UINotificationFeedbackGenerator()

    @StateObject var bookmarks = Api()
    @State var presentSettingsSheet = false
    @State var presentAddFormSheet = false
    
    func reload(){
        settings.objectWillChange.send()
        bookmarks.setProperty(domain: settings.domain, token: settings.token)
        bookmarks.reloadData()
    }
    
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
                                            bookmarks.delete(item: bookmark)
                                            Drops.show(
                                                makeDrops(title: "Removed", image: UIImage(systemName: "trash")!, accessibilityText: "Alert! Removed object.")
                                            )
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
                        reload()
                    }
                    .listStyle(.plain)
                } else if (bookmarks.status == Status.error) {
                    Text("Failed load data").padding(.bottom, 25)
                    Button {
                        presentSettingsSheet.toggle()
                    } label: {
                        Label("Open settings", systemImage: "gearshape.2")
                    }
                } else {
                    VStack {
                        ProgressView(){
                            Text("Loading")
                        }
                    }
                }
            }
            .sheet(isPresented: $presentSettingsSheet, onDismiss: {
                reload()
            }) {
                SettingView().environmentObject(settings)
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
                }.accentColor(Color("buttonColor"))
            )
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentAddFormSheet.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }.accentColor(Color("buttonColor"))
                
            )
            .onAppear {
                reload()
            }
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
