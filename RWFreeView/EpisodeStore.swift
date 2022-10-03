import Foundation

class EpisodeStore: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var domainFilters: [String: Bool] = [
        "1": true,
        "2": false,
        "3": false,
        "5": false,
        "8": false,
        "9": false
    ]
    @Published var difficultyFilters: [String: Bool] = [
        "advanced": false,
        "beginner": true,
        "intermediate": false
    ]
    
    func queryDomain(_ id: String) -> URLQueryItem {
        URLQueryItem(name: "filter[domain_ids][]", value: id)
    }
    
    func queryDifficulty(_ label: String) -> URLQueryItem {
        URLQueryItem(name: "filter[difficulties][]", value: label)
    }
    
    let filtersDictionary = [
        "1": "iOS & Swift",
        "2": "Android & Kotlin",
        "3": "Unity",
        "5": "macOS",
        "8": "Server-Side Swift",
        "9": "Flutter",
        "advanced": "Advanced",
        "beginner": "Beginner",
        "intermediate": "Intermediate"
    ]
    
    init() {
#if DEBUG
        createDevData()
#endif
    }
}

struct Episode {
    let name: String
    let description: String  // description_plain_text
    let released: String  // released_at
    let domain: String  // enum
    let difficulty: String  // enum
    let videoURLString: String  // will be videoIdentifier: Int
    let uri: String  // redirects to the real web page
    var linkURLString: String {
        "https://www.raywenderlich.com/redirect?uri=" + uri
    }
    
    static let domainDictionary = [
        "1": "iOS & Swift",
        "2": "Android & Kotlin",
        "3": "Unity",
        "5": "macOS",
        "8": "Server-Side Swift",
        "9": "Flutter"
    ]
}
