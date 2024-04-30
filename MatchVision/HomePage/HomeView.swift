//
//  HomeView.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0..<3) { _ in
                        NavigationLink(destination:VideoCellDetail()) {
                            videoCell()
                        }
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
