//
//  AddBookmarkView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/06/2023.
//

import SwiftUI

struct AddBookmarkView: View {
    
    @State var title: String = ""
    @State var url: String = ""
    @State var descr: String = ""
    @State var tags: String = ""
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("URL")) {
                    TextField("http://", text: $url)
                }
                Section(header: Text("Tags"), footer: Text("Enter any number of tags separated by space and without the hash (#). If a tag does not exist it will be automatically created.")) {
                    TextField("", text: $tags)
                }
                Section(header: Text("Title"), footer: Text("Optional, leave empty to use title from website.")) {
                    TextField("", text: $title)
                }
                Section(header: Text("Title"), footer: Text("Optional, leave empty to use description from website.")) {
                    TextField("", text: $descr, axis: .vertical)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("New bookmark")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Save").foregroundColor(Color("buttonColor"))
                    }
                )
        }
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView()
    }
}
