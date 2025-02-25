//
//  Extensions.swift
//  RaweCeek
//
//  Created by Gordon on 10.02.2025.
//

import Foundation
import JolpicaKit
import SwiftUI
import UIKit
import SwiftUIIntrospect

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

struct SeasonSelector: ViewModifier {
    struct BarContent: View {
        @EnvironmentObject var seasonViewModel: SeasonViewModel
        
        var body: some View {
            Picker(selection: $seasonViewModel.selectedSeason, content: {
                ForEach(seasonViewModel.seasons, id: \.self) {
                    Text($0.season)
                        .tag($0.season.lowercased())
                }
            }, label: {
                Text(seasonViewModel.selectedSeason)
            })
            .pickerStyle(.menu)
            .padding(.horizontal, 6)
            .padding(.vertical, 6)
            .menuIndicator(.hidden)
            .frame(width: 100, alignment: .trailing)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .introspect(.navigationStack, on: .iOS(.v17, .v18)) { navStack in
                let bar = navStack.navigationBar

                if !bar.subviews.contains(where: { $0.tag == 1337 }) {
                    let hosting = UIHostingController(rootView: BarContent())
                    
                    guard let hostingView = hosting.view else { return }
                    hostingView.backgroundColor = .clear
                    hostingView.tag = 1337
                    
                    bar.addSubview(hostingView)
                    
                    hostingView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        hostingView.trailingAnchor.constraint(equalTo: bar.trailingAnchor),
                        hostingView.bottomAnchor.constraint(equalTo: bar.bottomAnchor)
                    ])
                }
            }
    }
}

extension View {
    func seasonSelector() -> some View {
        modifier(SeasonSelector())
    }
}
