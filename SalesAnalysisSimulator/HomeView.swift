//
//  HomeView.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import SwiftUI

struct HomeView: View {
    @State var selectedView = 0
    var body: some View {
        TabView (selection: $selectedView){
            
            ContentView()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }.tag(0)
            ConsolesView()
                .tabItem {
                    Text("Consoles")
                    Image(systemName: "arcade.stick.console.fill")
                }.tag(1)
//
//            ThirdView()
//                .tabItem { Text("View 3") }
//                .tag(2)
            
            
        }
    }
}

#Preview {
    HomeView()
}
