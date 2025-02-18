//
//  EventRow.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import SwiftUI
import JolpicaKit

struct EventRow: View {
    let title: String
    let date: Date?
    let days: Int
    
    init(title: String, event: Event? = nil, date: Date? = nil) {
        self.title = title
        
        if let event {
            self.date = event.date
        } else if let date {
            self.date = date
        } else {
            self.date = nil
        }
        
        if let date = self.date {
            self.days = date.interval(ofComponent: .day, fromDate: Date.now)
        } else {
            self.days = 0
        }
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                if days != 0 {
                    Text("\(days * days.signum()) days \(days > 0 ? "left" : "ago")")
                        .font(.subheadline)
                        .foregroundStyle(.black.secondary)
                } else {
                    Text("Today")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            if let date {
                Text(date, style: .date)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    EventRow(title: "First Practice", event: .init(date: Calendar.current.date(byAdding: .day, value: 30, to: Date.now)!, time: ""))
}
