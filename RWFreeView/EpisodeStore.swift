import Foundation
import WidgetKit

extension FileManager {
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier:
                "group.com.dmitriyryndya.RWFreeView.episodes"
        )!
    }
}


final class EpisodeStore: ObservableObject, Decodable {
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
    
    @Published var loading = false

    var miniEpisodes: [MiniEpisode] = []

    func writeEpisodes() {
        let archiveURL = FileManager.sharedContainerURL()
            .appendingPathComponent("episodes.json")
        print(">>> \(archiveURL)")

        if let dataToSave = try? JSONEncoder().encode(miniEpisodes) {
            do {
                try dataToSave.write(to: archiveURL)
            } catch {
                print("Error: Can’t write episodes")
            }
        }
    }

    
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
    
    let baseURLString = "https://api.raywenderlich.com/api/contents"
    var baseParams = [
        "filter[subscription_types][]": "free",
        "filter[content_types][]": "episode",
        "sort": "-popularity",
        "page[size]": "20",
        "filter[q]": ""
    ]
    
    func fetchContents() {
        guard var urlComponents = URLComponents(string: baseURLString)
        else { return }
        urlComponents.setQueryItems(with: baseParams)
        let selectedDomains = domainFilters.filter {
            $0.value
        }
            .keys
        let domainQueryItems = selectedDomains.map {
            queryDomain($0)
        }
        
        let selectedDifficulties = difficultyFilters.filter {
            $0.value
        }
            .keys
        let difficultyQueryItems = selectedDifficulties.map {
            queryDifficulty($0)
        }
        
        urlComponents.queryItems! += domainQueryItems
        urlComponents.queryItems! += difficultyQueryItems
        guard let contentsURL = urlComponents.url else { return }
        print(contentsURL)
        loading = true
        
        URLSession.shared
            .dataTask(with: contentsURL) { data, response, error in
                defer {
                    DispatchQueue.main.async {
                        self.loading = false
                        WidgetCenter.shared.reloadTimelines(ofKind: "RWFreeViewWidget")
                    }
                }
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                    if let decodedResponse = try? JSONDecoder().decode(
                        EpisodeStore.self, from: data) {
                        DispatchQueue.main.async {
                            self.miniEpisodes = self.episodes.map {
                              MiniEpisode(
                                id: $0.id,
                                name: $0.name,
                                released: $0.released,
                                domain: $0.domain,
                                difficulty: $0.difficulty ?? "",
                                description: $0.description)
                            }
                            self.writeEpisodes()
                            self.episodes = decodedResponse.episodes
                        }
                        return
                    }
                }
                print(
                    "Contents fetch failed: " +
                    "\(error?.localizedDescription ?? "Unknown error")")
            }
            .resume()
    }
    
    func clearQueryFilters() {
        domainFilters.keys.forEach { domainFilters[$0] = false }
        difficultyFilters.keys.forEach {
            difficultyFilters[$0] = false
        }
    }
    
    init() {
        fetchContents()
    }
    
    
    enum CodingKeys: String, CodingKey {
        case episodes = "data"   // array of dictionary
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(
            keyedBy: CodingKeys.self)
        episodes = try container.decode(
            [Episode].self, forKey: .episodes)
    }
    
}
