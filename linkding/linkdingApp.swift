//
//  linkdingApp.swift
//  linkding
//
//  Created by Alexey Nikandrov on 18/06/2023.
//

import SwiftUI

@main
struct linkdingApp: App {
    @StateObject var appSettings = AppSettings()
    var body: some Scene {
        WindowGroup {
            BookmarkListView().environmentObject(appSettings)
        }
    }
}
