//
//  DriversViewModel.swift
//  RaweCeek
//
//  Created by Gordon on 14.02.2025.
//

import Foundation
import JolpicaKit

@MainActor
class ConstructorsViewModel: ObservableObject {
    @Published var standings = [ConstructorStanding]()
    
    func loadStandings() async {
        let result = await jolpica.constructorStandings.getConstructorStandings(season: "2024")
        
        if case .success(let data) = result {
            self.standings = data.result.standings.first?.standings ?? []
        }
    }
}
