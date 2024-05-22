import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Image("splash")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            // Simulate a delay before navigating to the IslandSelectionView
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive, content: {
            NavbarView()
        })
    }
}

// HOMEPAGE
// HOME - USER CARD
struct HomeUserCv: View {
    let userImage: Image
    let userName: String
    let totalScore: Int

    var body: some View {
        HStack {
            userImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Hi, \(userName)")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.heavy)

                HStack(spacing: 0) {
                    Text("Welcome back to ")
                    Text("TeWara")
                        .foregroundColor(.red)
                        .fontWeight(.heavy)
                    Text("!")
                }

                Text("Total Poin: \(totalScore) poin")
            }
            Spacer()
        }
        .padding()
        .background(
            ZStack {
                Color.white.opacity(0.6)
                    .blur(radius: 0.2)
            }
        )
        .cornerRadius(10)
        .shadow(radius: 0)
    }
}

// HOME - RANKS CARD
struct HomeRankCv: View {
    var body: some View {
        VStack {
            Text("Pencapaian").font(.title2).fontWeight(.heavy)

            // Island Rank 1
            HStack {
                Image("jawa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pulau Jawa")
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    
                    Text("100 poin")

                    Text("-20 untuk masuk peringkat")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 10) // Add padding to the bottom
            
            CustomDivider() // Use custom divider
            
            // Island Rank 2
            HStack {
                Image("kalimantan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pulau Kalimantan")
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    
                    Text("100 poin")

                    Text("-20 untuk masuk peringkat")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 10) // Add padding to the top
            .padding(.bottom, 10) // Add padding to the bottom
            
            CustomDivider() // Use custom divider
            
            // Island Rank 3
            HStack {
                Image("sumatera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pulau Sumatera")
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    
                    Text("100 poin")

                    Text("-20 untuk masuk peringkat")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 10) // Add padding to the top
        }
        .padding()
        .background(
            ZStack {
                Color.white.opacity(0.6)
                    .blur(radius: 0.2)
            }
        )
        .cornerRadius(10)
        .shadow(radius: 0)
    }
}

// Custom Divider
struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
            .padding(.horizontal, 20) // Add horizontal padding
    }
}

struct NavbarView: View {
    var body: some View {
        TabView {
            MainMenuView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Halaman Utama")
                }
            
            LeaderboardView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Peringkat")
                }
        }.accentColor(.red)
    }
}

// MAIN MENU
struct MainMenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HomeUserCv(userImage: Image(systemName: "person.circle.fill"), userName: "John Doe", totalScore: 100)
                        .padding()
                    
                    HomeRankCv().padding()
                    
                    NavigationLink(
                        destination: IslandSelectionView(),
                        label: {
                            Text("START GAME")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })
                }
            }
            .navigationBarTitle("Halaman Utama", displayMode: .inline)
        }
    }
}


// SELECT ISLAND
struct IslandSelectionView: View {
    @State private var playerName = ""
    let islandImages = [
        "Sumatera": Image("sumatera"),
        "Jawa": Image("jawa"),
        "Papua": Image("papua"),
        "Sulawesi": Image("sulawesi"),
        "Kalimantan": Image("kalimantan"),
        "Bali": Image("bali")
    ]

    @State private var selectedIsland: String?
    @State private var showQuizTypeSelection = false
    @State private var showingNameInput = false
    @State private var players: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                    ForEach(islandImages.keys.sorted(), id: \.self) { island in
                        Button(action: {
                            selectedIsland = island
                            showingNameInput = true
                        }) {
                            VStack {
                                islandImages[island]?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                                    .background(Color.red) // Set background color to red
                                    .cornerRadius(10) // Add corner radius to the background

                                Text(island)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.black) // Set text color to white
                                    .padding(.bottom, 8) // Add some padding at the bottom
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()

                    }
                }
                
                NavigationLink(
                    destination: QuizTypeSelectionView(selectedIsland: selectedIsland ?? "", playerName: playerName),
                    isActive: $showQuizTypeSelection
                ) {
//                    EmptyView()
                }
                .hidden()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Daftar Pulau", displayMode: .inline)
            .sheet(isPresented: $showingNameInput) {
                PlayerNameInputView(playerName: $playerName, players: $players, showQuizTypeSelection: $showQuizTypeSelection)
            }
        }
    }
}

struct PlayerNameInputView: View {
    @Binding var playerName: String
    @Binding var players: [String]
    @Binding var showQuizTypeSelection: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $playerName)
                .padding()
            
            Button("Start Game") {
                players.append(playerName)
                showQuizTypeSelection = true
                presentationMode.wrappedValue.dismiss() // Dismiss the current view
            }
            .padding()
        }
        .padding()
    }
}

struct QuizTypeSelectionView: View {
    let selectedIsland: String
    let playerName: String
    @State private var showTarianQuiz = false
    @State private var showBahasaQuiz = false
    
    var body: some View {
        VStack {
            Text("Welcome, \(playerName)! Select a quiz type for \(selectedIsland)")
                .font(.title)
                .padding()
            
            Button(action: {
                showTarianQuiz = true
            }) {
                Text("Traditional Dances")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                showBahasaQuiz = true
            }) {
                Text("Local Language")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            NavigationLink(
                destination: QuizView(selectedIsland: selectedIsland, playerName: playerName),
                isActive: $showTarianQuiz
            ) {
                EmptyView()
            }
            .hidden()
            
            NavigationLink(
                destination: LanguageQuizView(selectedIsland: selectedIsland, playerName: playerName),
                isActive: $showBahasaQuiz
            ) {
            }
            .hidden()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct QuizView: View {
    let selectedIsland: String
    let playerName: String
    let traditionalDances:[String: [(name: String, description: String)]] = [
         "Sumatera": [
            ("Tari Piring", "Tarian ini berasal dari Minangkabau dan mengandung nilai-nilai keagamaan."),
            ("Tari Pesisir", "Tarian ini berasal dari daerah pesisir Sumatera Barat yang melambangkan kegembiraan."),
            ("Tari Indang", "Tari Indang berasal dari Sumatera Barat yang biasanya ditampilkan saat acara pernikahan."),
            ("Tari Payung", "Tari Payung adalah tarian tradisional dari Sumatera Barat yang melibatkan payung sebagai properti utama.")
        ],
        "Jawa": [
            ("Tari Merak", "A dance depicting the movements of a peacock, symbolizing beauty and grace. Originates from Java."),
            ("Tari Reog", "A traditional dance form originating from Ponorogo, East Java, featuring a lion-like creature and other mythical figures."),
            ("Tari Bedhaya", "A sacred dance performed by female dancers in the Keraton (royal palace) of Yogyakarta, symbolizing the harmony of the universe."),
            ("Tari Ketuk Tilu", "A traditional dance from the Sundanese culture in West Java, often performed to welcome guests or celebrate special occasions.")
        ],
        "Papua": [
            ("Tari Perang", "A dance that mimics movements of war, often performed to commemorate battles or to showcase strength and bravery."),
            ("Tari Bakar Batu", "A dance traditionally performed during a ceremony where food is cooked using hot stones buried in the ground."),
            ("Tari Sajojo", "A lively dance from Papua, characterized by fast-paced movements and vibrant costumes."),
            ("Tari Wutukala", "A traditional dance from the Biak region, usually performed during rituals or to celebrate important events.")
        ],
        "Sulawesi": [
            ("Tari Kipas", "A dance using fans, often performed at celebrations and events."),
            ("Tari Bosara", "A traditional dance from the Bugis people of South Sulawesi, usually performed at weddings or cultural events."),
            ("Tari Maranding", "A dance from North Sulawesi, known for its graceful movements and storytelling aspects."),
            ("Tari Manimbong", "A traditional dance from the Minahasa region, often performed during harvest festivals and other celebrations.")
        ],
        "Kalimantan": [
            ("Tari Enggang", "A dance inspired by the movements of the Enggang (hornbill) bird, symbolizing the unity of Dayak tribes."),
            ("Tari Kancet Ledo", "A dance from the Dayak Kenyah tribe, usually performed to celebrate a successful headhunting expedition."),
            ("Tari Kancet Papatai", "A dance from the Dayak Bahau tribe, depicting the story of a hero who fought against injustice."),
            ("Tari Hudoq", "A dance performed by the Dayak tribe to welcome the rice planting season, featuring elaborate masks and costumes.")
        ],
        "Bali": [
            ("Tari Kecak", "Also known as the 'Monkey Dance,' it is a dance drama depicting scenes from the Ramayana epic."),
            ("Tari Barong", "A traditional Balinese dance representing the eternal battle between good (Barong) and evil (Rangda)."),
            ("Tari Pendet", "A welcoming dance performed by young girls, typically at the beginning of a ceremony."),
            ("Tari Legong", "A refined Balinese dance form characterized by intricate finger movements and expressive gestures, often performed by young girls.")
        ]
    ]
    
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isCorrect = false
    @State private var currentDanceIndex = 0
    @State private var currentDanceDescription = ""
    @State private var score = 0
    @State private var addedScore = 0
    @State private var remainingSeconds = 30
    @State private var timer: Timer?
    @State private var quizCompleted = false
    @State private var showBonusText = true
    @State private var showAlert = false
    @State private var alertImageName = ""

    var body: some View {
        VStack {
            Text("Remaining Time: \(remainingSeconds) seconds")
            
            Text("Tebak tarian daerah di \(selectedIsland)")
                .font(.title3)
            
            Image("\(selectedIsland.lowercased())_\(traditionalDances[selectedIsland]?[currentDanceIndex].name.lowercased().replacingOccurrences(of: " ", with: "_") ?? "")")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .padding()
                .onAppear {
                    setupQuiz()
                }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(0..<4) { index in
                    Button(action: {
                        selectedAnswerIndex = index
                        checkAnswer()
                        showBonusText = false
                    }) {
                        Text(traditionalDances[selectedIsland]?[index].name ?? "")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top, 4)
                            .frame(width: 150, height: 50) // Adjust dimensions as needed
                    }
                    .padding()
                    .background(selectedAnswerIndex == index ? Color.orange : Color.red)
                    .cornerRadius(8)
                    .disabled(selectedAnswerIndex != nil)
                }
            }
            .alert(isPresented: $showAlert) {
                if isCorrect {
                    return Alert(title: Text("Selamat!"),
                                 message: Text("Kamu mendapatkan +\(addedScore) poin."),
                                 dismissButton: .default(Text("Got it!")))
                } else {
                    return Alert(title: Text("Oops..."),
                                 message: Text("Kamu masih belum beruntung :)"),
                                 dismissButton: .default(Text("Got it!")))
                }
            }
            
            Spacer()
            
            if showBonusText && !isCorrect {
                Text("+20 POIN jika jawabanmu benar!!!")
                    .foregroundColor(.gray)
                    .italic()
            }
            
            Spacer()
            
            Text("Score : \(score)")
                .font(.headline)
            
            if quizCompleted {
                Button(action: {
                    resetQuiz()
                    showBonusText = true
                }) {
                    Text("Berikutnya...")
                        .font(.subheadline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
        .navigationBarTitle("Tebak Seni Tari", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func setupQuiz() {
        let dance = traditionalDances[selectedIsland]?[currentDanceIndex]
        currentDanceDescription = dance?.description ?? ""
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer.invalidate()
                calculateScore()
                quizCompleted = true
            }
        }
    }
    
    func calculateScore() {
        if isCorrect {
            addedScore = remainingSeconds * 10
            score += addedScore
        } else {
            score += 0
        }
    }

    func checkAnswer() {
        guard let correctAnswerIndex = traditionalDances[selectedIsland]?.firstIndex(where: { $0.name == traditionalDances[selectedIsland]?[currentDanceIndex].name }) else {
            return
        }
        isCorrect = selectedAnswerIndex == correctAnswerIndex
        
        timer?.invalidate()
        calculateScore()
        showAlert = true
        quizCompleted = true
    }

    func resetQuiz() {
        selectedAnswerIndex = nil
        isCorrect = false
        remainingSeconds = 30
        quizCompleted = false
        currentDanceIndex = (currentDanceIndex + 1) % (traditionalDances[selectedIsland]?.count ?? 0)
        setupQuiz()
    }
}

struct LanguageQuizView: View {
    let selectedIsland: String
    let playerName: String
    let islands: [String] = ["Sumatera", "Jawa", "Papua", "Sulawesi", "Kalimantan", "Bali"]
    @State private var currentIslandIndex = 0
    
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isCorrect = false
    @State private var currentDialog: String = ""
    @State private var score = 0
    @State private var addedScore = 0
    @State private var remainingSeconds = 30
    @State private var timer: Timer?
    @State private var quizCompleted = false
    @State private var showBonusText = true
    @State private var showAlert = false
    @State private var alertImageName = ""
    
    let localDialogs: [String: [String]] = [
        "Sumatera": [
            "Ayo pergi ke pasar!",
            "Hari ini cuaca sangat panas.",
            "Mari kita makan bersama.",
            "Berenang di pantai sangat menyenangkan."
        ],
        "Jawa": [
            "Aku wis pada turu.",
            "Kulo sira bisa maneh.",
            "Aku mboten ngerti.",
            "Dagangan iki sing paling murah."
        ],
        "Papua": [
            "Yene aite dege dege yen kedi kasi.",
            "Koe kamu iki wedi.",
            "Bole kupas pinang.",
            "Uwekla ciki ciki."
        ],
        "Sulawesi": [
            "Dio dio kuoka uya.",
            "Ari masio ui buo laiyolo.",
            "Leko kasi laiyolo.",
            "Uliamianga kuoka bisulamianga."
        ],
        "Kalimantan": [
            "Kamon serei kita ni.",
            "Mangan keno yo.",
            "Baro basikul ku urang.",
            "Ngingu beuki beuki kaca."
        ],
        "Bali": [
            "Adi kene sampun mejejeg olih.",
            "Tiange muregane di mari.",
            "Nyak de papa silih.",
            "Pedanda nanging mangda pegat."
        ]
    ]
    
    var body: some View {
        VStack {
            Text("Waktu Tersisa: \(remainingSeconds) detik")
                .padding()
            
            Text(currentDialog)
                .font(.title)
                .fontWeight(.heavy)
            Text("merupakan bahasa daerah ...")
                .font(.title)
                .onAppear {
                    setupQuiz()
                }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(0..<4) { index in
                    Button(action: {
                        selectedAnswerIndex = index
                        checkAnswer()
                        showBonusText = false
                    }) {
                        Text(islands[index])
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.top, 4)
                            .frame(width: 150, height: 50)
                    }
                    .padding()
                    .background(selectedAnswerIndex == index ? Color.orange : Color.red)
                    .cornerRadius(8)
                    .disabled(selectedAnswerIndex != nil)
                }
            }
            .alert(isPresented: $showAlert) {
                if isCorrect {
                    return Alert(title: Text("Selamat!"),
                                 message: Text("Kamu mendapatkan +\(addedScore) poin."),
                                 dismissButton: .default(Text("Got it!")))
                } else {
                    return Alert(title: Text("Oops..."),
                                 message: Text("Kamu masih belum beruntung :)"),
                                 dismissButton: .default(Text("Got it!")))
                }
            }

            Spacer()

            if showBonusText && !isCorrect {
                Text("+20 POIN jika jawabanmu benar!!!")
                    .foregroundColor(.gray)
                    .italic()
            }

            Spacer()
            
            Text("Skor : \(score)")
                .font(.headline)
                .padding()

            if quizCompleted {
                Button(action: {
                    nextQuestion()
                    showBonusText = true
                }) {
                    Text("Berikutnya...")
                        .font(.subheadline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
        .navigationBarTitle("Tebak Bahasa", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func setupQuiz() {
        let island = islands[currentIslandIndex]
        currentDialog = localDialogs[island]?.randomElement() ?? ""
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer.invalidate()
                calculateScore()
                quizCompleted = true
            }
        }
    }
    
    func calculateScore() {
        if isCorrect {
            addedScore = remainingSeconds * 10
            score += addedScore
        } else {
            score += 0 // Reset score to 0 if answer is incorrect
        }
        print("Skor: \(score)")
    }

    func checkAnswer() {
        guard let correctAnswerIndex = islands.firstIndex(of: islands[currentIslandIndex]) else {
            return
        }
        isCorrect = selectedAnswerIndex == correctAnswerIndex
        
        timer?.invalidate()
        calculateScore()
        showAlert = true
        quizCompleted = true
    }
    
    func nextQuestion() {
        currentIslandIndex = (currentIslandIndex + 1) % islands.count
        selectedAnswerIndex = nil
        isCorrect = false
        remainingSeconds = 30
        quizCompleted = false
        setupQuiz()
    }
}

struct LeaderboardView: View {
    @State private var leaderboardData: [String: [LeaderboardEntry]] = [
        "Jawa": [
            LeaderboardEntry(name: "Louis Fernando", score: 1000),
            LeaderboardEntry(name: "Jacklyn Kim", score: 788),
            LeaderboardEntry(name: "Kezia Tangun", score: 540),
        ],
        "Kalimantan": [
            LeaderboardEntry(name: "Michael Smith", score: 950),
            LeaderboardEntry(name: "Emily Johnson", score: 820),
            LeaderboardEntry(name: "Daniel Lee", score: 700),
        ],
        "Sumatera": [
            LeaderboardEntry(name: "Sophia Brown", score: 1100),
            LeaderboardEntry(name: "Noah Wilson", score: 890),
            LeaderboardEntry(name: "Emma Garcia", score: 600),
        ]
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(leaderboardData.keys.sorted(), id: \.self) { island in
                        Section(header: Text(island).font(.title2)
                                    .fontWeight(.bold)) {
                            ForEach(leaderboardData[island]!.prefix(3)) { entry in
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                    
                                    Text(entry.name)
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("\(entry.score)")
                                        .fontWeight(.bold)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .navigationBarTitle("Peringkat", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
}

struct IslandSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
