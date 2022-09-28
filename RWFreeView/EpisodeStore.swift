import Foundation

class EpisodeStore: ObservableObject {
    @Published var episodes: [Episode] = []
    
    init() {
#if DEBUG
        createDevData()
#endif
    }
}

struct Episode {
    let name: String
    let description: String
    let released: String
    let domain: String
    let difficulty: String
    let videoURLString: String
    let uri: String
    var linkURLString: String {
        "https://www.raywenderlich.com/redirect?uri=" + uri
    }
}
