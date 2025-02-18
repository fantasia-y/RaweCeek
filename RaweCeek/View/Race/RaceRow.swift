//
//  RaceRow.swift
//  RaweCeek
//
//  Created by Gordon on 12.02.2025.
//

import SwiftUI
import JolpicaKit

struct RaceRow: View {
    @EnvironmentObject var countryHelper: CountryCodeHelper
    
    let race: Race
    
    var body: some View {
        NavigationLink(value: race) {
            HStack(spacing: 12) {
                if let code = countryHelper.getCountryCode(race.circuit.location.country) {
                    Image("\(code)")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(.rect(cornerRadius: 6))
                } else {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.gray.secondary)
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "questionmark")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(race.raceName)
                        .font(.headline)
                    
                    Text("\(race.round) - \(race.circuit.circuitName)")
                        .font(.caption)
                        .foregroundStyle(.black.secondary)
                }
                
                Spacer()
                
                Text(race.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.black.secondary)
            }
        }
    }
}
