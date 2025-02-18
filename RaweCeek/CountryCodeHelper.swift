//
//  CountryHelper.swift
//  RaweCeek
//
//  Created by Gordon on 12.02.2025.
//

import Foundation

struct Country: Decodable {
    let name: String
    let code: String
}

class CountryCodeHelper: ObservableObject {
    @Published var countries = [Country]()
    
    func loadCountries() {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            fatalError("countries.json not found")
        }
        
        do {
            let data = try Data(contentsOf: url)
            self.countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            fatalError("Couldn't decode countries.json")
        }
    }
    
    func getCountryCode(_ name: String) -> String? {
        return self.countries.first(where: { $0.name == name })?.code
    }
}
