import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
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
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, episode: sampleEpisode)
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
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
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
    }
}


struct RWFreeViewWidget_Previews: PreviewProvider {
    static var previews: some View {
        RWFreeViewWidgetEntryView(entry: SimpleEntry(date: Date(), episode: Provider().sampleEpisode))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
