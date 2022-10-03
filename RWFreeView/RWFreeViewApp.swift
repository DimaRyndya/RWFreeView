import SwiftUI

@main
struct RWFreeViewApp: App {
    @StateObject private var store = EpisodeStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
