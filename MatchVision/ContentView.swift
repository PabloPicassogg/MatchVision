//
//  ContentView.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
               // 第一个 Tab
            HomeView()
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("First")
            }

               // 第二个 Tab
               Text("Second Tab")
                   .tabItem {
                       Image(systemName: "2.square.fill")
                       Text("Second")
                   }
                   
               // 第三个 Tab
               Text("Third Tab")
                   .tabItem {
                       Image(systemName: "3.square.fill")
                       Text("Third")
                   }
           }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
