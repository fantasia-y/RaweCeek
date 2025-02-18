//
//  FlagView.swift
//  RaweCeek
//
//  Created by Gordon on 14.02.2025.
//

import SwiftUI

struct FlagView: View {
    @EnvironmentObject var countryHelper: CountryCodeHelper
    
    let country: String
    
    var body: some View {
        if let code = countryHelper.getCountryCode(country) {
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
    }
}
