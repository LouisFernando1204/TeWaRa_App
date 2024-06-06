//
//  RegisterView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI
import AppKit

struct RegisterViewMac: View {
    
    @StateObject private var homeController = HomeController()
    @State private var textInput = ""
    @State private var selectedImage: Data?
    @State private var isImagePickerPresented = false
    @State private var navToHomeView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    struct ImagePicker: NSViewControllerRepresentable {
        
        @Binding var selectedImage: Data?
        @Environment(\.presentationMode) var presentationMode
        
        func makeNSViewController(context: Context) -> NSViewController {
            let viewController = NSViewController()
            DispatchQueue.main.async {
                let panel = NSOpenPanel()
                panel.allowedContentTypes = [.image]
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                
                panel.begin { response in
                    if response == .OK, let url = panel.url, let imageData = try? Data(contentsOf: url) {
                        selectedImage = imageData
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
            return viewController
        }
        
        func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
            // Tidak ada pembaruan yang diperlukan di sini
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
        
        class Coordinator: NSObject {
            let parent: ImagePicker
            
            init(parent: ImagePicker) {
                self.parent = parent
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenSize = geometry.size
                
                ScrollView {
                    VStack(alignment: .center) {
                        setUpRegisterView(screenSize: screenSize)
                    }
                    .padding(.horizontal, screenSize.width / 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.white)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Oops..."),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                //                .onAppear {
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                //                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                //                    }
                //                }
                //                .onDisappear {
                //                    MusicPlayer.shared.stopBackgroundMusic()
                //                }
                .navigationDestination(isPresented: $navToHomeView) {
                    HomeViewMac()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func setUpRegisterView(screenSize: CGSize) -> some View {
        VStack(alignment: .center) {
            self.logo(screenSize: screenSize)
            self.greetings(screenSize: screenSize)
            self.showTextInputField(screenSize: screenSize)
            self.showSelectedImageOrPlaceholder(screenSize: screenSize)
            self.showRegisterButton(screenSize: screenSize)
        }
        .padding(.vertical, screenSize.height / 20)
    }
    
    private func logo(screenSize: CGSize) -> some View {
        Image("logo(TeWaRa)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenSize.width/8, height: screenSize.width/8)
            .padding(.bottom, screenSize.height/150)
    }
    
    private func greetings(screenSize: CGSize) -> some View {
        Text("Halo, Sobat TeWaRa!")
            .font(.system(size: screenSize.width/35, weight: .bold))
            .foregroundColor(.clear)
            .multilineTextAlignment(.center)
            .overlay(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                        .init(color: Color("darkredColor(TeWaRa)"), location: 1.0),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .mask(
                    Text("Halo, Sobat TeWaRa!")
                        .font(.system(size: screenSize.width/35, weight: .bold))
                        .multilineTextAlignment(.center)
                )
            )
    }
    
    private func showTextInputField(screenSize: CGSize) -> some View {
        VStack(alignment: .center) {
            if let imageData = selectedImage, let nsImage = NSImage(data: imageData) {
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenSize.width / 12, height: screenSize.width / 12)
                    .clipShape(Circle())
                    .overlay(
                        Circle().strokeBorder(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 4
                        )
                    )
                    .padding(.top, screenSize.height / 100)
                    .padding(screenSize.width / 30)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Image("profilePictureIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenSize.width / 12, height: screenSize.width / 12)
                    .colorMultiply(Color.gray)
                    .clipShape(Circle())
                    .padding(.top, screenSize.height / 100)
                    .padding(screenSize.width / 30)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            HStack {
                Text("Nama")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Tuliskan nama mu...", text: $textInput)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding(.leading, screenSize.width / 60)
                .padding(.vertical, screenSize.height / 50)
                .frame(maxWidth: .infinity)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .foregroundColor(.black)
        }
        .padding(.bottom, screenSize.height / 65)
        .frame(maxWidth: .infinity)
    }
    
    private func showSelectedImageOrPlaceholder(screenSize: CGSize) -> some View {
        VStack(alignment: .center) {
            HStack {
                Text("Foto profil")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Pilih foto profil mu")
                    .font(.title2)
                    .padding(.vertical, screenSize.height / 40)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .padding(.bottom, screenSize.height / 20)
        .frame(maxWidth: .infinity)
    }
    
    private func showRegisterButton(screenSize: CGSize) -> some View {
        Button(
            action: {
                homeController.registerAccount(
                    textInput: self.textInput,
                    selectedImage: self.selectedImage,
                    showAlert: $showAlert,
                    alertMessage: $alertMessage
                )
                if (!showAlert) {
                    self.navToHomeView = true
                }
            },
            label: {
                Text("Selanjutnya")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, screenSize.height / 60)
                    .frame(maxWidth: .infinity)
            }
        )
        .buttonStyle(PlainButtonStyle())
        .background(
            Color("redColor(TeWaRa)")
                .cornerRadius(screenSize.width / 30)
        )
        .shadow(radius: 10, y: 4)
        .sheet(isPresented: $navToHomeView) {
            HomeViewMac()
        }
    }
}

#Preview {
    RegisterViewMac()
}
