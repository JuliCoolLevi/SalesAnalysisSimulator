//
//  ConsolesView.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import SwiftUI

struct Console: Identifiable {
    let id = UUID()
    let name: String
    let maker: String
    let release: Int
    let unitsSoldM: Double
    let blurb: String
    let topGames: [String]
}

let sampleConsoles: [Console] = [
    .init(name: "Wii", maker: "Nintendo", release: 2006, unitsSoldM: 101,
          blurb: "Motion controls and family-friendly hits made it a cultural moment.",
          topGames: ["Wii Sports", "Mario Kart Wii", "Wii Fit"]),
    .init(name: "NES", maker: "Nintendo", release: 1983, unitsSoldM: 62,
          blurb: "Revived home consoles with iconic platformers and action classics.",
          topGames: ["Super Mario Bros.", "Zelda", "Metroid"]),
    .init(name: "GB", maker: "Nintendo", release: 1989, unitsSoldM: 119,
          blurb: "8-bit handheld phenomenon with swappable cartridges.",
          topGames: ["Tetris", "Pokémon Red/Blue"]),
    .init(name: "DS", maker: "Nintendo", release: 2004, unitsSoldM: 154,
          blurb: "Dual screens + touch gameplay defined mobile Nintendo for a decade.",
          topGames: ["New Super Mario Bros.", "Mario Kart DS"]),
    .init(name: "PS3", maker: "Sony", release: 2006, unitsSoldM: 87,
          blurb: "Blu-ray era with big first-party franchises.",
          topGames: ["GTA V", "The Last of Us"]),
    .init(name: "PS2", maker: "Sony", release: 2000, unitsSoldM: 155,
          blurb: "Best-selling home console; massive library and DVD playback.",
          topGames: ["GTA: San Andreas", "Gran Turismo 3"]),
    .init(name: "X360", maker: "Microsoft", release: 2005, unitsSoldM: 84,
          blurb: "Xbox Live popularized online console gaming.",
          topGames: ["Halo 3", "Minecraft"]),
    .init(name: "SNES", maker: "Nintendo", release: 1990, unitsSoldM: 49,
          blurb: "16-bit classics with polished platformers and RPGs.",
          topGames: ["Super Mario World", "A Link to the Past"])
]

struct ConsolesView: View {
    private var consoles = sampleConsoles
    private var peak = sampleConsoles.map(\.unitsSoldM).max() ?? 1
    
    var body: some View {
        NavigationStack {
            Text("Consoles (Nostalgia)").bold()
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(consoles) { console in
                        ConsoleCardView(console: console, peakUnits: peak)
                    }
                }
            }
        }
    }
}

struct ConsoleCardView: View {
    
    var console : Console
    let peakUnits: Double
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text("🎮 \(console.name)")
                    .font(.headline)
                    .padding(.horizontal)
                Spacer()
                Text(console.maker)
                    .font(.caption)
                    .padding(.horizontal, 15).padding(.vertical, 4)
                    .background(Capsule().fill(Color.blue.opacity(0.15)))
            }
            
            Text(console.blurb)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .padding(.horizontal)
            
            HStack {
                Label("\(console.release)", systemImage: "calendar")
                Spacer()
                Label("\(console.unitsSoldM, specifier: "%.0f")M sold", systemImage: "chart.bar")
            }
            .font(.caption)
            
            .padding(20)
            .frame(width: 350, height: 50, alignment: .topLeading)
            .background(
                Color.blue
                    .blur(radius: 100)
                    .shadow(radius: 5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(.horizontal, 25)
            
            
            
        }
    }
    
}

#Preview {
    ConsolesView()
}
