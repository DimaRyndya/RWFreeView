import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    let store = EpisodeStore()

    let sampleEpisode = Episode(
        id: "5117655",
        uri: "rw://betamax/videos/3021",
        name: "SwiftUI vs. UIKit",
        released: "Sept 2019",
        difficulty: "beginner",
        description: "Learn about the differences between SwiftUI and"
        + "UIKit, and whether you should learn SwiftUI, UIKit, or "
        + "both.\n" ,
        parentName: nil,
        domain: "iOS & Swift")


    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), episode: sampleEpisode)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), episode: sampleEpisode)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let interval = 3
        for index in 0 ..< store.episodes.count {
          let entryDate = Calendar.current.date(
            byAdding: .second,
            value: index * interval,
            to: currentDate)!
          let entry = SimpleEntry(
            date: entryDate,
            episode: store.episodes[index])
          entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let episode: Episode
}

struct RWFreeViewWidgetEntryView : View {
    @Environment(\.widgetFamily) var family

    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                PlayButtonIcon(width: 50, height: 50, radius: 10)
                    .unredacted()
                VStack(alignment: .leading) {
                    Text(entry.episode.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    if family != .systemSmall {
                        HStack {
                            Text(entry.episode.released + "  ")
                            Text(entry.episode.domain + "  ")
                            Text(String(entry.episode.difficulty ?? "")
                                .capitalized)
                        }
                    } else {
                        Text(entry.episode.released + "  ")
                    }
                }
            }
            .foregroundColor(Color(UIColor.label))

            if family != .systemSmall {
                Text(entry.episode.description)
                    .lineLimit(2)
            }
        }
        .padding(.horizontal)
        .background(Color.itemBkgd)
        .font(.footnote)
        .foregroundColor(Color(UIColor.systemGray))

    }
}

@main
struct RWFreeViewWidget: Widget {
    let kind: String = "RWFreeViewWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            RWFreeViewWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("RW Free View")
        .description("View free raywenderlich.com video episodes.")
        .supportedFamilies([.systemMedium])
    }
}


struct RWFreeViewWidget_Previews: PreviewProvider {
    static var previews: some View {
        let view = RWFreeViewWidgetEntryView(
            entry: SimpleEntry(
                date: Date(),
                episode: Provider().sampleEpisode))
        view.previewContext(WidgetPreviewContext(family: .systemSmall))
        view.previewContext(WidgetPreviewContext(family: .systemMedium))
        view.previewContext(WidgetPreviewContext(family: .systemLarge))

    }
}
