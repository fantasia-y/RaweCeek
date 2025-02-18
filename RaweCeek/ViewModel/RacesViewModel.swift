//
//  RacesViewModel.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import Foundation
import JolpicaKit

@MainActor
class RacesViewModel: ObservableObject {
    @Published var races: [Race] = []
    @Published var firstRace: Race? = nil
    
    func loadRaces() async {
        let result = await jolpica.races.getRaces(season: "2024")
        
        if case .success(let data) = result {
            self.firstRace = data.result.races.first
            if data.result.races.count > 1 {
                self.races = Array(data.result.races[1...])
            } else {
                self.races = []
            }
        }
    }
}
