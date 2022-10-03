import SwiftUI

struct FilterOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: EpisodeStore
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Spacer()
                Button(
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                            .background(
                                Circle().fill((Color.closeBkgd))
                            )
                    }
                    .padding([.top, .trailing])
            }
            VStack {
                Text("Filters")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                List {
                    VStack(alignment: .leading) {
                        Text("Platforms")
                            .font(.title2)
                            .padding(.bottom)
                        VStack(alignment: .leading) {
                            AdaptingStack {
                                Button("iOS & Swift") { store.domainFilters["1"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.domainFilters["1"]!, width: nil))
                                Button("Android & Kotlin") { store.domainFilters["2"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.domainFilters["2"]!, width: nil))
                                Button("macOS") { store.domainFilters["5"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.domainFilters["5"]!, width: nil))
                                AdaptingStack {
                                    Button("Server-Side Swift") { store.domainFilters["8"]!.toggle() }
                                        .buttonStyle(FilterButtonStyle(selected: store.domainFilters["8"]!, width: nil))
                                    Button("Unity") { store.domainFilters["3"]!.toggle() }
                                        .buttonStyle(FilterButtonStyle(selected: store.domainFilters["3"]!, width: nil))
                                    Button("Flutter") { store.domainFilters["9"]!.toggle() }
                                        .buttonStyle(FilterButtonStyle(selected: store.domainFilters["9"]!, width: nil))
                                }
                                .padding(.bottom)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Difficulty")
                                .font(.title2)
                                .padding(.vertical)
                            AdaptingStack {
                                Button("Beginner") { store.difficultyFilters["beginner"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.difficultyFilters["beginner"]!, width: nil))
                                Button("Intermediate") { store.difficultyFilters["intermediate"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.difficultyFilters["intermediate"]!, width: nil))
                                Button("Advanced") { store.difficultyFilters["advanced"]!.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: store.difficultyFilters["advanced"]!, width: nil))
                            }
                            .padding(.bottom)
                        }
                    }
                    Spacer()
                    HStack {
                        Button("Clear All") { }
                            .buttonStyle(FilterButtonStyle(selected: false, width: 160))
                        Button("Apply") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(FilterButtonStyle(selected: true, width: 160))
                    }
                    .padding(.bottom)
                    .font(.title2)
                }
            }
        }
    }

}

    struct FilterButtonStyle: ButtonStyle {
        let selected: Bool
        let width: CGFloat?

        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(.white)
                .frame(width: width)
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selected ? Color.greenButton : Color.grayButton)
                )
        }
    }

    struct FilterOptionsView_Previews: PreviewProvider {
        static var previews: some View {
            FilterOptionsView()
        }
    }
