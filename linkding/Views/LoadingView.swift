//
//  LoadingView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 26/06/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image("loadingImage").resizable().scaledToFit().frame(width: 300)
            Text("loading data")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
