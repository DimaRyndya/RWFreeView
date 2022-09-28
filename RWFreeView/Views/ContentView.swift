import SwiftUI

struct ContentView: View {
    @StateObject private var store = EpisodeStore()
    
    var body: some View {
        List(store.episodes, id: \.name) { episode in
            EpisodeView(episode: episode)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
