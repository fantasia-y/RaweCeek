//
//  CircuitLoader.swift
//  RaweCeek
//
//  Created by Gordon on 11.02.2025.
//

import Foundation
import MapKit
import JolpicaKit

struct CircuitProperties: Decodable {
    let id: String
    let location: String
    let name: String
    let opened: Int
    let firstGP: Int
    let length: Int
    let altitude: Int
    
    var overlay: MKPolyline?
    
    enum CodingKeys: String, CodingKey {
        case id
        case location = "Location"
        case name = "Name"
        case opened
        case firstGP = "firstgp"
        case length
        case altitude
    }
}

class CircuitLoader: ObservableObject {
    @Published var circuits = [CircuitProperties]()
    
    func load() {
        guard let url = Bundle.main.url(forResource: "f1-circuits", withExtension: "geojson") else {
            fatalError("f1-circuits.geojson not found")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let circuits = try MKGeoJSONDecoder().decode(data)
            
            for item in circuits {
                if let feature = item as? MKGeoJSONFeature, let properties = feature.properties {
                    var circuitProperties = try JSONDecoder().decode(CircuitProperties.self, from: properties)
                    
                    for geo in feature.geometry {
                        if let line = geo as? MKPolyline {
                            circuitProperties.overlay = line
                        }
                    }
                    self.circuits.append(circuitProperties)
                }
            }
        } catch {
            fatalError("Unable to decode geojson")
        }
    }
    
    func getCircuitProperties(_ circuit: Circuit) -> CircuitProperties? {
        return self.circuits.first(where: {
            $0.location == circuit.location.locality ||
            $0.location == circuit.location.country ||
            $0.name == circuit.circuitName
        })
    }
}
