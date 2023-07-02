//
//  Statics.swift
//  linkding
//
//  Created by Alexey Nikandrov on 30/06/2023.
//

import Foundation
import SwiftUI

func openBookmartURL(url: String) {
    let url: URL? = URL(string: url)!
    guard url != nil else {
        return
    }
    UIApplication.shared.open(url!)
}

func CopyToClip(text: String){
    UIPasteboard.general.string = text
}


