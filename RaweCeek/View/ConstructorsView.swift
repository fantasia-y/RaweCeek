//
//  ConstructorsView.swift
//  RaweCeek
//
//  Created by Gordon on 18.02.2025.
//

import SwiftUI
import JolpicaKit

struct ConstructorsView: View {
    @StateObject var viewModel = ConstructorsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.standings, id: \.self) { standing in
                    NavigationLink(value: standing) {
                        ConstructorRow(standing: standing, totalPoints: viewModel.standings.first!.points)
                    }
                }
            }
//            .navigationDestination(for: Race.self) {
//                RaceView(race: $0)
//            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Teams")
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
    
    struct ConstructorRow: View {
        let standing: ConstructorStanding
        let totalPoints: String
        
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                Text("\(standing.positionText)")
                    .frame(minWidth: 20, alignment: .center)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(standing.constructor.name, bundle: Bundle.main))
                        .frame(width: 30, height: 30)
                    
                    Image("\(standing.constructor.name)_small")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(standing.constructor.name)
                    
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
    ConstructorsView()
        .environmentObject(CountryCodeHelper())
}
