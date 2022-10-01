import SwiftUI

struct ContentView: View {
    @StateObject private var store = EpisodeStore()

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "top-bkgd")
        appearance.largeTitleTextAttributes =
        [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes =
        [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = UIColor(named: "list-bkgd")
    }

    
    var body: some View {
        NavigationView {
            List(store.episodes, id: \.name) { episode in
                NavigationLink(destination: PlayerView(episode: episode)) {
                    EpisodeView(episode: episode)
                }
            }
            .navigationTitle("Videos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
