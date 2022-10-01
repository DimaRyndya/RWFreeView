import SwiftUI

struct EpisodeView: View {
    let episode: Episode
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            PlayButtonIcon(width: 40, height: 40, radius: 6)
            VStack(alignment: .leading, spacing: 6) {
                Text(episode.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                AdaptingStack {
                    Text(episode.released + "  ")
                    Text(episode.domain + "  ")
                    Text(String(episode.difficulty).capitalized)
                }
                Text(episode.description)
                    .lineLimit(2)
            }
            .padding(.horizontal)
            .font(.footnote)
            .foregroundColor(Color(UIColor.systemGray))
        }
        .padding(10)
        .background(Color.itemBkgd)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: EpisodeStore().episodes[0])
            .previewLayout(.sizeThatFits)
    }
}
