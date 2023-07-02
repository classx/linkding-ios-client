//
//  Statics.swift
//  linkding
//
//  Created by Alexey Nikandrov on 30/06/2023.
//

import Foundation
import SwiftUI
import Drops

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


func copyDrops() -> Drop {
    let drop = Drop(
        title: "Copied!",
        icon: UIImage(systemName: "link"),
        action: .init {
            Drops.hideCurrent()
        },
        position: .top,
        duration: 2.0,
        accessibility: "Alert: Copied!"
    )
    return drop
}

