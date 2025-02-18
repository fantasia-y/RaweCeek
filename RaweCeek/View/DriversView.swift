//
//  DriversView.swift
//  RaweCeek
//
//  Created by Gordon on 14.02.2025.
//

import SwiftUI
import JolpicaKit

struct DriversView: View {
    @StateObject var viewModel = DriversViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.standings, id: \.self) { standing in
                    NavigationLink(value: standing) {
                        DriverRow(standing: standing, totalPoints: viewModel.standings.first!.points)
                    }
                }
            }
//            .navigationDestination(for: Race.self) {
//                RaceView(race: $0)
//            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Drivers")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.loadStandings()
            }
        }
        .onAppear {
            if viewModel.standings.isEmpty {
                Task {
                    await viewModel.loadStandings()
                }
            }
        }
    }
    
    struct DriverRow: View {
        let standing: DriverStanding
        let totalPoints: String
        
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                Text("\(standing.positionText)")
                    .frame(minWidth: 20, alignment: .center)
                
                FlagView(country: standing.driver.nationality ?? "")
                
                RoundedRectangle(cornerRadius: 90)
                    .fill(Color(standing.constructors.first?.name ?? "None", bundle: Bundle.main))
                    .frame(width: 6, height: 30)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(standing.driver.givenName) \(standing.driver.familyName)")
                    
                    HStack(alignment: .center) {
                        ProgressView(value: Double(standing.points), total: Double(totalPoints)!)
                            .progressViewStyle(CustomProgressStyle())
                        
                        Text(standing.points)
                            .font(.subheadline)
                            .foregroundStyle(.black.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    DriversView()
        .environmentObject(CountryCodeHelper())
}
