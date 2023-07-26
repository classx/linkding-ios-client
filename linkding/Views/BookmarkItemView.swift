//
//  BookmarkItemView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI
import Drops

struct BookmarkItemView: View {
    @State private var isPresentingConfirm: Bool = false
    var item: Bookmark
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack{
                Text(item.title).font(.system(.headline, design: .default)).foregroundColor(Color("titleColor")).lineLimit(1)
                Spacer()
            }
            HStack{
                Text(item.description).font(.system(.subheadline, design: .default)).foregroundColor(Color("descrtiptionColor")).lineLimit(2)
                Spacer()
            }
//            HStack {
//                Text("Tag").font(.system(.footnote, design: .default))
//                Text("Tag").font(.system(.footnote, design: .default))
//                Text("Tag").font(.system(.footnote, design: .default))
//                Spacer()
//            }
        }

    }
}


//struct BookmarkItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkItemView()
//    }
//}
