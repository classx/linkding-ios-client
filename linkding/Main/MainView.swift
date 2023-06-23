//
//  ContentView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

struct MainView: View {
    @State private var showingSheet = false
    var body: some View {
        NavigationStack {
            List {
                Text("1")
                Text("1")
                Text("1")
                Text("1")
            }
            .refreshable {
                print("refresh here")
            }
            .onAppear()
            .listStyle(.plain)
            .navigationTitle("Linkding")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "person.circle")
                    }
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    /*/
                    NavigationLink {
                        Text("Add")
                    } label: {
                        Image(systemName: "plus")
                    }
                    */
                    Button("Show Sheet") {
                                showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet) {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
