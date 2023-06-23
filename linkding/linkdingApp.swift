//
//  linkdingApp.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

@main
struct linkdingApp: App {
    @StateObject var data: DataStore = DataStore(NetworkManager())
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(data)
        }
    }
}
