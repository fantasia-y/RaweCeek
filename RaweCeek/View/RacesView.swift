//
//  RacesView.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import SwiftUI
import JolpicaKit

struct RacesView: View {
    @EnvironmentObject var seasonViewModel: SeasonViewModel
    @StateObject var viewModel = RacesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let firstRace = viewModel.firstRace {
                    TrackView(race: firstRace, height: 300)
                        .clipShape(.rect(cornerRadius: 12))
                        .listRowSeparator(.hidden)
                        .overlay {
                            NavigationLink("", value: firstRace)
                                .opacity(0)
                        }
                }
                
                ForEach(viewModel.races, id: \.round) { race in
                    RaceRow(race: race)
                }
            }
            .navigationDestination(for: Race.self) {
                RaceView(race: $0)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Races")
            .toolbarTitleDisplayMode(.inlineLarge)
            .refreshable {
                await viewModel.loadRaces()
            }
        }
        .onAppear {
            if viewModel.races.isEmpty {
                Task {
                    await viewModel.loadRaces()
                }
            }
        }
        .seasonSelector()
        .onChange(of: seasonViewModel.selectedSeason) { _, selected in
            Task {
                await viewModel.loadRaces(season: selected)
            }
        }
    }
}

#Preview {
    ContentView()
}
