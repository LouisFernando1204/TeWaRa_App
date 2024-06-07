import SwiftUI

struct IslandViewMac: View {
    private let islands: [Island] = [
        ModelData.shared.sumatera,
        ModelData.shared.java,
        ModelData.shared.kalimantan,
        ModelData.shared.papua,
        ModelData.shared.sulawesi,
        ModelData.shared.bali
    ]
    
    @State private var selectedIsland: String = ""
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.sumatera)
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    //    @State var alreadySelected: Bool = false
    @State var selectSumateraAndGetDance: Bool = false
    @State var selectSumateraAndGetLanguage: Bool = false
    @State var selectKalimantanAndGetDance: Bool = false
    @State var selectKalimantanAndGetLanguage: Bool = false
    @State var selectBaliAndGetDance: Bool = false
    @State var selectBaliAndGetLanguage: Bool = false
    @State var selectSulawesiAndGetDance: Bool = false
    @State var selectSulawesiAndGetLanguage: Bool = false
    @State var selectPapuaAndGetDance: Bool = false
    @State var selectPapuaAndGetLanguage: Bool = false
    @State var selectJavaAndGetDance: Bool = false
    @State var selectJavaAndGetLanguage: Bool = false
    
    init() {
        self.selectedIsland = ""
        self.selectSumateraAndGetDance = false
        self.selectSumateraAndGetLanguage = false
        self.selectKalimantanAndGetDance = false
        self.selectKalimantanAndGetLanguage = false
        self.selectBaliAndGetDance = false
        self.selectBaliAndGetLanguage = false
        self.selectSulawesiAndGetDance = false
        self.selectSulawesiAndGetLanguage = false
        self.selectPapuaAndGetDance = false
        self.selectPapuaAndGetLanguage = false
        self.selectJavaAndGetDance = false
        self.selectJavaAndGetLanguage = false
    }
    
    //    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var isNavigate = false
    
    var body: some View {
        self.setUpIslandView()
    }
    
    func setUpIslandView() -> some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    TopNavigationBar(ScreenSize: geometry.size, name: "Pulau", message: "Beranda")
                    
                    Spacer().frame(height: 44)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(0..<islands.count, id:\.self) { index in
                                
                                Button(action: {
                                    islandController.addUserToArray(islandName: islands[index].islandName)
                                    self.selectedIsland = islands[index].islandName
                                    
                                    if self.selectedIsland == "Sumatera" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.sumatera
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSumateraAndGetDance = true
                                            
                                        }
                                        else {
                                            self.selectSumateraAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Sulawesi" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.sulawesi
                                        print(ModelData.shared.currentIslandObject.islandName)
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSulawesiAndGetDance = true
                                        }
                                        else {
                                            self.selectSulawesiAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Kalimantan" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.kalimantan
                                        if islandController.getChosenGameByRandom() {
                                            self.selectKalimantanAndGetDance = true
                                        }
                                        else {
                                            self.selectKalimantanAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Papua" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.papua
                                        if islandController.getChosenGameByRandom() {
                                            self.selectPapuaAndGetDance = true
                                        }
                                        else {
                                            self.selectPapuaAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Bali" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.bali
                                        if islandController.getChosenGameByRandom() {
                                            self.selectBaliAndGetDance = true
                                        }
                                        else {
                                            self.selectBaliAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Jawa" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.java
                                        if islandController.getChosenGameByRandom() {
                                            self.selectJavaAndGetDance = true
                                        }
                                        else {
                                            self.selectJavaAndGetLanguage = true
                                        }
                                    }
                                }) {
                                    ZStack(alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 20)
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
                                            .frame(width: geometry.size.width/3.4 ,height: geometry.size.width/5)
                                        
                                        VStack {
                                            Image(islands[index].islandImage)
                                                .resizable()
                                                .frame(width: geometry.size.width/5, height: geometry.size.width/8)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding([.leading, .trailing], 10)
                                                .padding(.bottom, 20)
                                            Text(islands[index].islandName)
                                                .font(.largeTitle)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.white)
                                                .padding(.bottom, 20)
                                        }
                                        
                                    }
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                            MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                                        }
                                    }
                                    .onDisappear {
                                        MusicPlayer.shared.stopBackgroundMusic()
                                    }
                                    .padding()
                                    .onTapGesture {
                                        islandController.addUserToArray(islandName: islands[index].islandName)
                                        self.selectedIsland = islands[index].islandName
                                        if self.selectedIsland == "Sumatera" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.sumatera
                                            if islandController.getChosenGameByRandom() {
                                                self.selectSumateraAndGetDance = true
                                            }
                                            else {
                                                self.selectSumateraAndGetLanguage = true
                                            }
                                        }
                                        else if self.selectedIsland == "Sulawesi" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.sulawesi
                                            if islandController.getChosenGameByRandom() {
                                                self.selectSulawesiAndGetDance = true
                                            }
                                            else {
                                                self.selectSulawesiAndGetLanguage = true
                                            }
                                        }
                                        else if self.selectedIsland == "Kalimantan" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.kalimantan
                                            if islandController.getChosenGameByRandom() {
                                                self.selectKalimantanAndGetDance = true
                                            }
                                            else {
                                                self.selectKalimantanAndGetLanguage = true
                                            }
                                        }
                                        else if self.selectedIsland == "Papua" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.papua
                                            if islandController.getChosenGameByRandom() {
                                                self.selectPapuaAndGetDance = true
                                            }
                                            else {
                                                self.selectPapuaAndGetLanguage = true
                                            }
                                        }
                                        else if self.selectedIsland == "Bali" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.bali
                                            if islandController.getChosenGameByRandom() {
                                                self.selectBaliAndGetDance = true
                                            }
                                            else {
                                                self.selectBaliAndGetLanguage = true
                                            }
                                        }
                                        else if self.selectedIsland == "Jawa" {
                                            ModelData.shared.currentIslandObject = ModelData.shared.java
                                            if islandController.getChosenGameByRandom() {
                                                self.selectJavaAndGetDance = true
                                            }
                                            else {
                                                self.selectJavaAndGetLanguage = true
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                        }
                        .padding()
                    }
                }
                .navigationTitle("Pulau")
                
            }
            .background(Color.white)
            .navigationDestination(isPresented: $selectSumateraAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.sumatera)
            }
            .navigationDestination(isPresented: $selectSumateraAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.sumatera)
            }
            
            .navigationDestination(isPresented: $selectKalimantanAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.kalimantan)
            }
            .navigationDestination(isPresented: $selectKalimantanAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.kalimantan)
            }
            
            .navigationDestination(isPresented: $selectPapuaAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.papua)
            }
            .navigationDestination(isPresented: $selectPapuaAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.papua)
            }
            
            .navigationDestination(isPresented: $selectBaliAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.bali)
            }
            .navigationDestination(isPresented: $selectBaliAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.bali)
            }
            
            .navigationDestination(isPresented: $selectJavaAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.java)
            }
            .navigationDestination(isPresented: $selectJavaAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.java)
            }
            
            .navigationDestination(isPresented: $selectSulawesiAndGetDance) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.sulawesi)
            }
            .navigationDestination(isPresented: $selectSulawesiAndGetLanguage) {
                TraditionalDanceViewMac(selectedIsland: ModelData.shared.sulawesi)
            }
        }
    }
}




struct TopNavigationBar : View {
    
    let ScreenSize: CGSize
    let name: String
    let message: String
    
    @State private var navigate: Bool = false
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Image("backIconWhite")
                
                Text(message)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .font(ScreenSize.width > 600 ? .title : .headline)
            }
            .onTapGesture {
                self.navigate = true
            }
            .navigationDestination(isPresented: $navigate) {
                if message == "Beranda" {
                    TabViewMac()
                }
                else if message == "Pulau" {
                    IslandViewMac()
                }
            }
            
            Spacer()
            
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(ScreenSize.width > 600 ? .title : .headline)
            
            Spacer()
            
            NavigationLink(
                destination: EmptyView()) {
                    HStack(spacing: 4) {
                        Image("backIconWhite")
                            .opacity(0)
                        
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(ScreenSize.width > 600 ? .largeTitle : .headline)
                            .opacity(0)
                    }
                }
                .opacity(0)
        }
        .padding(.horizontal)
        //        .padding(.bottom, ScreenSize.width > 600 ? 20 : 10)
        .frame(height: ScreenSize.width/24)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .edgesIgnoringSafeArea(.top)
        )
    }
}

#Preview {
    IslandViewMac()
}
