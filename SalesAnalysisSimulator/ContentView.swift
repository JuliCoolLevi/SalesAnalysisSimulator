//
//  ContentView.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import SwiftUI

struct ContentView: View {
    @State private var itemsBestSelling: [BestSeller] = []
    @State private var errorText: String?

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.black.opacity(0.2),
                                        Color.blue.opacity(0.25)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            
                List(itemsBestSelling) { item in
                    HStack {
                        Text(item.name)
                            .lineLimit(1)
                        Spacer()
                        Text("\(item.sales, specifier: "%.2f") M")
                            .monospacedDigit()
                            .bold()
                            .foregroundStyle(.blue)
                            .accessibilityLabel("\(item.sales) million")
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Top 10 Best-Selling")
        }
        .task {
            do {
                itemsBestSelling = try MyViewModel().getBestSellers(limit: 10)
            } catch {
                errorText = "DB query failed: \(error.localizedDescription)"
            }
        }
    }
}


#Preview {
    ContentView()
}
