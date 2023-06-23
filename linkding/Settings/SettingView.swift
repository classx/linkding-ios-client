//
//  SettingView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

struct SettingView: View {
    @State var name: String = ""
    @State var url: String = ""
    @State var token: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account")) {
                    TextField("Name", text: $name)
                    TextField("http://", text: $url)
                    TextField("Token", text: $token)
                }
                LabeledContent("Version", value: "0.1")
                Button("Reset all data") {
                    // DO SOMETHING
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button("Save") {
                    print("About tapped!")
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
