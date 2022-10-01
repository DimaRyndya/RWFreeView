import SwiftUI

struct HeaderView: View {
    let count: Int
    @State private var queryTerm = ""
    @State private var sortOn = "popular"
    
    var body: some View {
        VStack {
            SearchField(queryTerm: $queryTerm)
            HStack {
                Button("Clear all") { }
                    .buttonStyle(HeaderButtonStyle())
                Button("iOS & Swift") { }
                    .buttonStyle(HeaderButtonStyle())
                Spacer()
            }
            HStack {
                Text("\(count) Episodes")
                Menu("\(Image(systemName: "filemenu.and.cursorarrow"))") {
                  Button("10 results/page") { }
                  Button("20 results/page") { }
                  Button("30 results/page") { }
                  Button("No change") { }
                }

                Spacer()
                Picker("", selection: $sortOn) {
                    Text("New").tag("new")
                    Text("Popular").tag("popular")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 130)
                .background(Color.gray.opacity(0.8))
            }
            .foregroundColor(Color.white.opacity(0.6))
        }
        .font(.subheadline)
        .foregroundColor(.white)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .leading)
        .listRowInsets(EdgeInsets())
        .padding()
        .background(Color.topBkgd)
        .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
        .background(Color.listBkgd)
    }
}

struct SearchField: View {
    @Binding var queryTerm: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if queryTerm.isEmpty {
                Text("\(Image(systemName: "magnifyingglass")) Search videos")
                    .foregroundColor(Color.white.opacity(0.6))
            }
            TextField("", text: $queryTerm)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white.opacity(0.2)))
    }
}

struct HeaderButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Image(systemName: "xmark")
            configuration.label
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.2))
        )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(count: 42)
            .previewLayout(.sizeThatFits)
    }
}
