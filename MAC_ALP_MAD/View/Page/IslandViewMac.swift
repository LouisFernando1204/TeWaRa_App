import SwiftUI

struct IslandModel: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct IslandViewMac: View {
    let islands: [IslandModel] = [
        IslandModel(name: "Sumatera", imageName: "sumatera"),
        IslandModel(name: "Jawa", imageName: "jawa"),
        IslandModel(name: "Kalimantan", imageName: "kalimantan"),
        IslandModel(name: "Papua", imageName: "papua"),
        IslandModel(name: "Sulawesi", imageName: "sulawesi"),
        IslandModel(name: "Bali", imageName: "bali")
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var isNavigate = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopNavigationBar(destination: AnyView(Text("Destination")), name: "Pulau")
            
            
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(islands) { islandModel in
                    NavigationLink(destination: IslandDetailView(island: islandModel)) {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                                            Color(red: 118/255, green: 20/255, blue: 20/255)  // #761414
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(height: 180)
                            
                            VStack {
                                Image(islandModel.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding([.leading, .trailing], 10)
                                Text(islandModel.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                            }
                            
                            Button(action: {
                                self.isNavigate = true
                            }, label: {
                                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                            })
                            
                        }
                        .padding()
                    }
                }
            }
            .padding()
            
            BottomBar()
        }
        .navigationTitle("Pulau")
    }
}

struct TopNavigationBar: View {
    let destination: AnyView
    let name: String
    
    var body: some View {
        HStack {
            NavigationLink(destination: destination) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                    Text("Back")
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                            Color(red: 251/255, green: 146/255, blue: 60/255) // #FB923C
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(10)
            }
            
            Spacer()
            
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer(minLength: 90)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .edgesIgnoringSafeArea(.top)
        )
    }
}

struct BottomBar: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                        Color(red: 251/255, green: 146/255, blue: 60/255) // #FB923C
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 50)
            .padding(.horizontal, -20)
            .padding(.bottom, -35)
    }
}

struct IslandDetailView: View {
    let island: IslandModel
    
    var body: some View {
        Text("Details for \(island.name)")
            .font(.largeTitle)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandViewMac()
            .frame(width: 800, height: 600)
    }
}
