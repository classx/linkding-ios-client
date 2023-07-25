//
//  SettingView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var settings: AppSettings
    @State var name: String = ""
    @State var url: String = ""
    @State var token: String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account")) {
                    TextField("http://", text: settings.$domain)
                    TextField("Token", text: settings.$token)
                }
                Section(header: Text("About")) {
                    LabeledContent("Version", value: "0.1")
                }
                Section(){
                    Button("Reset all data") {
                        // DO SOMETHING
                        dismiss()
                    }
                }
                
            }
            .navigationTitle("Profile")
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
