import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: EpisodeStore
    @State private var showFilters = false
    @State private var selectedEpisode: Episode?
    
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
            List {
                HeaderView(count: store.episodes.count)
                if store.loading && store.episodes.isEmpty {
                    ActivityIndicator()
                }
                ForEach(store.episodes) { episode in
                    ZStack {
                        NavigationLink(
                            destination: PlayerView(episode: episode),
                            tag: episode,
                            selection: $selectedEpisode) {
                                EmptyView()
                            }
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                        EpisodeView(episode: episode)
                            .onTapGesture {
                                selectedEpisode = episode
                            }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 8)
                    .padding([.leading, .trailing], 20)
                    .background(Color.listBkgd)
                }
                .redacted(reason: store.loading ? .placeholder : [])
            }
            .navigationTitle("Videos")
            .toolbar {
                ToolbarItem {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .accessibilityLabel(Text("Shows filter options"))
                    }
                }
            }
            .sheet(isPresented: $showFilters) {
                FilterOptionsView()
                    .environmentObject(store)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onOpenURL { url in
          if let id = url.host,
            let widgetEpisode = store.episodes.first(
              where: { $0.id == id }) {
            selectedEpisode = widgetEpisode
          }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EpisodeStore())
    }
}
