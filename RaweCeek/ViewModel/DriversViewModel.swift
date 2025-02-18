//
//  DriversViewModel.swift
//  RaweCeek
//
//  Created by Gordon on 14.02.2025.
//

import Foundation
import JolpicaKit

@MainActor
class DriversViewModel: ObservableObject {
    @Published var standings = [DriverStanding]()
    
    func loadStandings() async {
        let result = await jolpica.driverStandings.getDriverStandings(season: "2024")
        
        if case .success(let data) = result {
            self.standings = data.result.standings.first?.standings ?? []
        }
    }
}
