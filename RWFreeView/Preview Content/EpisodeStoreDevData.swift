import Foundation

extension EpisodeStore {
    func createDevData() {
        episodes = [
            Episode(
                name: "SwiftUI vs. UIKit",
                description: "Learn about the differences between SwiftUI and UIKit, and whether you should learn SwiftUI, UIKit, or both.\n",
                released: "Sept 2019",
                domain: "iOS & Swift",
                difficulty: "beginner",
                videoURLString: "https://player.vimeo.com/external/357115704.m3u8?s=19d68c614817e0266d6749271e5432675a45c559&oauth2_token_id=897711146",
                uri: "rw://betamax/videos/3021"),
            Episode(
                name: "Challenge: Making a Programming To-Do List",
                description: "Make a programming to-do list of all the things you'll need to do to build the game. This helps build a good programming practice of gathering requirements first!\n",
                released: "Sept 2019",
                domain: "iOS & Swift",
                difficulty: "beginner",
                videoURLString: "https://player.vimeo.com/external/357115706.m3u8?s=e23cffbec2648d976c11be8ddb1729001f4ea179&oauth2_token_id=897711146",
                uri: "rw://betamax/videos/3022"),
            Episode(
                name: "Introduction",
                description: "Getting started with Android development begins right here. Learn about what you'll be making in this course.\n",
                released: "Mar 2018",
                domain: "Android & Kotlin",
                difficulty: "beginner",
                videoURLString: "https://player.vimeo.com/external/257192338.m3u8?s=c3bcd1dbbfd6897317084fb21987af6b89f81ec5&oauth2_token_id=897711146",
                uri: "rw://betamax/videos/1450")
        ]
    }
}
