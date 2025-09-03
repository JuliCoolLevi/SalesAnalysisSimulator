//
//  ContentView.swift
//  SalesAnalysisSimulator
//
//  Created by Julius Nillo on 2025-09-03.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [BestSeller] = []
    @State private var errorText: String?

    var body: some View {
        NavigationStack {
            List(items) { item in
                HStack {
                    Text(item.name).lineLimit(1)
                    Spacer()
                    Text(String(format: "%.2f M", item.sales))
                        .monospacedDigit()
                        .bold()
                        .accessibilityLabel("\(item.sales) million")
                }
            }
            .navigationTitle("Top 10 Best-Selling")
            .overlay {
                if let err = errorText {
                    Text(err).foregroundStyle(.red).padding()
                }
            }
        }
        .task {
            do {
                items = try MyViewModel().getBestSellers(limit: 10)
            } catch {
                errorText = "DB query failed: \(error.localizedDescription)"
            }
        }
    }
}



#Preview {
    ContentView()
}
