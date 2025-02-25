//
//  SeasonViewModel.swift
//  RaweCeek
//
//  Created by Gordon on 25.02.2025.
//

import Foundation
import JolpicaKit

@MainActor
class SeasonViewModel: ObservableObject {
    @Published var seasons = [Season]()
    @Published var selectedSeason = "current"
    
    func loadSeasons() async {
        let result = await jolpica.seasons.getSeasons(offset: 0, limit: 100)
        
        if case .success(let data) = result {
            if let current = data.result.seasons.last {
                self.seasons.append(.init(season: "Current", url: current.url))
            }

            if data.result.seasons.count > 1 {
                self.seasons.append(contentsOf: data.result.seasons.reversed()[1...])
            }
        }
    }
}
