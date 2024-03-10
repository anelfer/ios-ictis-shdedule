//
//  ContentView.swift
//  ictis shedule
//
//  Created by Alexander Rafshnayder on 30.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int
        
        init(selectedTab: Int) {
            _selectedTab = State(initialValue: selectedTab)
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Label("Shedule", systemImage: "house")
                }
                .tag(0)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: 0)
    }
}
