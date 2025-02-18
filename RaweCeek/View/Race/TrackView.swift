//
//  TrackView.swift
//  RaweCeek
//
//  Created by Gordon on 12.02.2025.
//

import SwiftUI
import MapKit
import JolpicaKit

struct TrackView: View {
    @EnvironmentObject var circuitLoader: CircuitLoader
    
    let race: Race
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(interactionModes: []) {
                if let circuit = circuitLoader.getCircuitProperties(race.circuit) {
                    MapPolyline(circuit.overlay!)
                        .stroke(.red, lineWidth: 4)
                        .mapOverlayLevel(level: .aboveLabels)
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll, showsTraffic: false))
            .allowsHitTesting(false)
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(height: 60)
                .overlay(alignment: .leading) {
                    HStack(spacing: 12) {
                        FlagView(country: race.circuit.location.country)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(race.getIntervalString())
                                .font(.system(size: 12))
                                .foregroundStyle(.black.secondary)
                            
                            Text(race.raceName)
                                .fontWeight(.semibold)
                            
                            Text("\(race.round) - \(race.circuit.circuitName)")
                                .font(.system(size: 12))
                                .foregroundStyle(.black.secondary)
                        }
                        .padding(.vertical)
                    }
                    .padding()
                }
        }
        .frame(height: height)
    }
}

#Preview {
    TrackView(race: .init(season: "", round: "7", url: "", raceName: "Monaco Grand Prix", circuit: .init(circuitId: "", url: "", circuitName: "Circuit de Monaco", location: .init(lat: "43.7347", long: "7.42056", locality: "Monte-Carlo", country: "Monaco")), date: Date.now, time: "", firstPractice: .init(date: Date.now, time: ""), secondPractice: .init(date: Date.now, time: ""), thirdPractice: .init(date: Date.now, time: ""), qualifying: .init(date: Date.now, time: ""), sprint: nil, sprintQualifying: nil), height: 400)
        .environmentObject(CircuitLoader())
        .environmentObject(CountryCodeHelper())
}
