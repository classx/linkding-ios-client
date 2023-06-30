//
//  BookmarkItemView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct BookmarkItemView: View {
    var item: Bookmark
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(item.title).font(.system(.headline, design: .rounded))
                Spacer()
            }
            HStack{
                Text(item.description).font(.system(.body, design: .rounded))
                Spacer()
            }
        }//.padding(.bottom, 10)
        .swipeActions(edge: .trailing){

            Button {
                openBookmartURL(url: self.item.url)
            } label: {
                Label("Open in Safari", systemImage: "safari")
            }
            .tint(.indigo)
            
            Button {
                print("Delete")
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
            
            Button {
                //openBookmartURL(url: self.item.url)
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            //.tint(.indigo)
        }
        .swipeActions(edge: .leading) {
            Button {
                print("Copy URL")
            } label: {
                Label("Copy URL", systemImage: "doc.on.doc")
            }
            .tint(.blue)
        }
    }
}

//struct BookmarkItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkItemView()
//    }
//}
