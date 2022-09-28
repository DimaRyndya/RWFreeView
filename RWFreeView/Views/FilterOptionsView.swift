import SwiftUI

struct FilterOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selected1 = false  // iOS
    @State private var selected2 = false  // Android
    @State private var selected3 = false  // Unity
    @State private var selected5 = false  // macOS
    @State private var selected8 = false  // SSS
    @State private var selected9 = false  // Flutter
    
    @State private var selectedB = false  // Beginner
    @State private var selectedI = false  // Intermediate
    @State private var selectedA = false  // Advanced
    
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
                                Button("iOS & Swift") { selected1.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected1, width: nil))
                                Button("Android & Kotlin") { selected2.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected2, width: nil))
                                Button("macOS") { selected5.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected5, width: nil))
                            }
                            AdaptingStack {
                                Button("Server-Side Swift") { selected8.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected8, width: nil))
                                Button("Unity") { selected3.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected3, width: nil))
                                Button("Flutter") { selected9.toggle() }
                                    .buttonStyle(FilterButtonStyle(selected: selected9, width: nil))
                            }
                            .padding(.bottom)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Difficulty")
                            .font(.title2)
                            .padding(.vertical)
                        AdaptingStack {
                            Button("Beginner") { selectedB.toggle() }
                                .buttonStyle(FilterButtonStyle(selected: selectedB, width: nil))
                            Button("Intermediate") { selectedI.toggle() }
                                .buttonStyle(FilterButtonStyle(selected: selectedI, width: nil))
                            Button("Advanced") { selectedA.toggle() }
                                .buttonStyle(FilterButtonStyle(selected: selectedA, width: nil))
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

struct FilterButtonStyle: ButtonStyle {
    let selected: Bool
    let width: CGFloat?
    
    func makeBody(configuration: Self.Configuration)
    -> some View {
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
