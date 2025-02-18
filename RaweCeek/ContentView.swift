//
//  ContentView.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import SwiftUI
import JolpicaKit

struct ContentView: View {
    @StateObject var circuitLoader = CircuitLoader()
    @StateObject var countryHelper = CountryCodeHelper()
    
    var body: some View {
        TabView {
            RacesView()
                .tabItem {
                    Label("Races", systemImage: "house")
                }
            
            ResultsView()
                .tabItem {
                    Label("Results", systemImage: "house")
                }
            
            ConstructorsView()
                .tabItem {
                    Label("Teams", systemImage: "house")
                }
            
            DriversView()
                .tabItem {
                    Label("Drivers", systemImage: "house")
                }
        }
        .environmentObject(circuitLoader)
        .environmentObject(countryHelper)
        .onAppear() {
            self.circuitLoader.load()
            self.countryHelper.loadCountries()
        }
    }
}

#Preview {
    ContentView()
}
