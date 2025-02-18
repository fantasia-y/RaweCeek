//
//  RaceView.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import SwiftUI
import JolpicaKit
import MapKit

struct RaceView: View {
    @EnvironmentObject var circuitLoader: CircuitLoader
    @Namespace var animation
    
    @State var circuit: CircuitProperties?
    let race: Race
    var position: MapCameraPosition
    
    init(race: Race) {
        self.race = race
        self.position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: Double(race.circuit.location.lat)!, longitude: Double(race.circuit.location.long)!),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                TrackView(race: race, height: 400)
//                .offset(y: -geometry.frame(in: .global).minY)
//                .frame(height: geometry.frame(in: .global).minY + 400)
            }
            .frame(height: 400)
            
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    VStack(spacing: 2) {
                        Text("Country")
                            .foregroundStyle(.black.secondary)
                            .font(.system(size: 14))
                        
                        Text(race.circuit.location.country)
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                        
                        Text(race.circuit.location.locality)
                            .foregroundStyle(.black.secondary)
                            .font(.system(size: 14))
                    }
                    .padding(.horizontal, 24)
                    
                    Divider()
                    
                    VStack(spacing: 2) {
                        Text("Layout")
                            .foregroundStyle(.black.secondary)
                            .font(.system(size: 14))
                        
                        Text(race.circuit.location.country)
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 24)
                    
                    if let circuit {
                        Divider()
                        
                        VStack(spacing: 2) {
                            Text("Length")
                                .foregroundStyle(.black.secondary)
                                .font(.system(size: 14))
                            
                            Text("\(circuit.length)")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                            
                            Text("km")
                                .foregroundStyle(.black.secondary)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 24)
                        
                        Divider()
                        
                        VStack(spacing: 2) {
                            Text("Altitude")
                                .foregroundStyle(.black.secondary)
                                .font(.system(size: 14))
                            
                            Text("\(circuit.altitude)")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                            
                            Text("m")
                                .foregroundStyle(.black.secondary)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(12)
            }
            .scrollIndicators(.hidden)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Schedule")
                    .font(.system(size: 20, weight: .bold))
                
                VStack(spacing: 12) {
                    if let firstPractice = race.firstPractice {
                        EventRow(title: "Practice 1", event: firstPractice)
                        Divider()
                    }
                    if let secondPractice = race.secondPractice {
                        EventRow(title: "Practice 2", event: secondPractice)
                        Divider()
                    }
                    if let thirdPractice = race.thirdPractice {
                        EventRow(title: "Practice 3", event: thirdPractice)
                        Divider()
                    }
                    if let sprintQualifying = race.sprintQualifying {
                        EventRow(title: "Sprint Qualifying", event: sprintQualifying)
                        Divider()
                    }
                    if let qualifying = race.qualifying {
                        EventRow(title: "Qualifying", event: qualifying)
                        Divider()
                    }
                    if let sprint = race.sprint {
                        EventRow(title: "Sprint", event: sprint)
                        Divider()
                    }
                    EventRow(title: "Race", date: race.date)
                }
//                .padding()
//                .background(.lightGray)
//                .cornerRadius(12)
                
//                Picker("Tab", selection: .constant("")) {
//                    Text("Featured").tag("")
//                    Text("Live").tag("live")
//                    Text("Movies").tag("movie")
//                    Text("Series").tag("series")
//                }
//                .pickerStyle(.segmented)
            }
            .padding()
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            self.circuit = self.circuitLoader.getCircuitProperties(self.race.circuit)
        }
    }
}

#Preview {
    RaceView(race: .init(season: "", round: "7", url: "", raceName: "Monaco Grand Prix", circuit: .init(circuitId: "", url: "", circuitName: "Circuit de Monaco", location: .init(lat: "43.7347", long: "7.42056", locality: "Monte-Carlo", country: "Monaco")), date: Date.now, time: "", firstPractice: .init(date: Date.now, time: ""), secondPractice: .init(date: Date.now, time: ""), thirdPractice: .init(date: Date.now, time: ""), qualifying: .init(date: Date.now, time: ""), sprint: nil, sprintQualifying: nil))
        .environmentObject(CircuitLoader())
        .environmentObject(CountryCodeHelper())
}
