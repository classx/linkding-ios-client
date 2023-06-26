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
    }
}

//struct BookmarkItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkItemView()
//    }
//}