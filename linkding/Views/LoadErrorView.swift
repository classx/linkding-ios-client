//
//  LoadErrorView.swift
//  linkding
//
//  Created by Alexey Nikandrov on 26/06/2023.
//

import SwiftUI

struct LoadErrorView: View {
    var body: some View {
        VStack{
            Image("errorImage")
            Text("Failed load data").padding(.bottom, 25)
            Button {
                print("Goto setting")
            } label: {
                Label("Goto setting", systemImage: "slider.horizontal.3")
            }
        }
    }
}

struct LoadErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadErrorView()
    }
}
