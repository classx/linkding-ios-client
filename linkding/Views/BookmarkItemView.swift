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
                print("Delete")
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
            
            Button {
                print("Share")
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .tint(.indigo)
            
            
        }
        .swipeActions(edge: .leading) {
            Button {
                print("Mark as favorite")
            } label: {
                Label("Unread", systemImage: "star")
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
