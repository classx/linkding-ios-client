//
//  AppSettings.swift
//  linkding
//
//  Created by Alexey Nikandrov on 23/07/2023.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("domain") var domain: String = ""
    @AppStorage("token") var token: String = ""
}
