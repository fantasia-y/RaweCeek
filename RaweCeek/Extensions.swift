//
//  Extensions.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import Foundation
import JolpicaKit
import SwiftUI

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}

extension Race {
    func getIntervalString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        let end = formatter.string(for: self.date)
        
        var interval = end ?? ""
        
        if let firstPractice {
            interval = "\(Calendar.current.component(.day, from: firstPractice.date)) - " + interval
        }
        
        return interval
    }
}

struct CustomProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 90)
                .fill(.gray.secondary)
                .frame(width: geometry.size.width * progress)
        }
        .frame(height: 4)
    }
}
