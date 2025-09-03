import SwiftUI

struct ContentView: View {
    @State private var itemsBestSelling: [BestSeller] = []
    
    @State private var itemsPlatforms: [PlatformGames] = []

    @State private var itemsGenres: [Genre] = []
    
    
    @State private var errorText: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.black.opacity(0.2),
                                        Color.blue.opacity(0.25)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                List {
                    // Best-selling games
                    Section("Top 10 Best-Selling") {
                        ForEach(itemsBestSelling) { item in
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
                    }
                    
                    Section("Most Games by Platform") {
                        ForEach(itemsPlatforms) { p in
                            HStack {
                                Text(p.name)
                                Spacer()
                                Text("\(p.platformCount) Games")
                                    .monospacedDigit()
                                    .bold()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    Section("Most Common Genres") {
                        ForEach(itemsGenres) { g in
                            HStack {
                                Text(g.genre)
                                Spacer()
                                Text("\(g.gameCount)")
                                    .monospacedDigit()
                                    .bold()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                  
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Top 10 Best-Selling")
        }
        .task {
            do {
                let vm = MyViewModel()
                itemsBestSelling = try vm.getBestSellers(limit: 10)
                itemsPlatforms   = try vm.getPlatformsByGameCount(limit: 10)
                itemsGenres      = try vm.getTopGenresByCount(limit: 10)
                
            } catch {
                errorText = "DB query failed"
            }
        }
    }
}

#Preview {
    ContentView()
}
