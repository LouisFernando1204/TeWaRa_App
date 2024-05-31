//
//  RegisterView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 19/05/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var homeController = HomeController()
    @State private var textInput = ""
    @State private var selectedImage: Data?
    @State private var isImagePickerPresented = false
    @State private var navToHomeView = false
    @State private var showAlert = false
    @State private var showWarningMessage = false
    @State private var alertMessage = ""
    
    private var screenSize = ScreenSize()
    
    struct ImagePicker: UIViewControllerRepresentable {
        
        @Binding var selectedImage: Data?
        @Environment(\.presentationMode) var presentationMode
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let parent: ImagePicker
            
            init(parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.selectedImage = uiImage.jpegData(compressionQuality: 1.0)
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
        
        let isIpad = ScreenSize.screenWidth > 600
        
        ScrollView{
            VStack(alignment: .center){
                setUpRegisterView(isIpad: isIpad)
            }
            .padding(.horizontal, isIpad ? ScreenSize.screenWidth/20 : ScreenSize.screenWidth/15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Oops..."),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        // pindah ke home background music nya
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
    }
    
    private func setUpRegisterView(isIpad: Bool) -> some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            self.logo(isIpad: isIpad)
            self.greetings(isIpad: isIpad)
            self.showTextInputField(isIpad: isIpad)
            self.showSelectedImageOrPlaceholder(isIpad: isIpad)
            self.showRegisterButton(isIpad: isIpad)
        }
        .padding(.vertical, isIpad ? ScreenSize.screenHeight/17 : ScreenSize.screenHeight/70)
    }
    
    private func logo(isIpad: Bool) -> some View {
        Image("logo(TeWaRa)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: isIpad ? ScreenSize.screenWidth/3.5 : ScreenSize.screenHeight/5.8)
            .padding(.bottom, 10)
    }
    
    private func greetings(isIpad: Bool) -> some View {
        Text("Halo, Sobat TeWaRa!")
            .font(isIpad ? .largeTitle : .title)
            .fontWeight(.bold)
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
                        .font(isIpad ? .largeTitle : .title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                )
            )
            .padding(.bottom, isIpad ? ScreenSize.screenHeight/25 : ScreenSize.screenHeight/35)
    }
    
    private func showTextInputField(isIpad: Bool) -> some View {
        VStack(alignment: .center) {
            // Display the selected image or placeholder
            if let imageData = selectedImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: isIpad ?  ScreenSize.screenWidth/6 : ScreenSize.screenWidth/3.3, height: isIpad ?  ScreenSize.screenWidth/6 : ScreenSize.screenWidth/3.3)
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
                    .padding(.top, 4)
                    .padding(isIpad ? ScreenSize.screenWidth/20 : ScreenSize.screenWidth/16)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Image("profilePictureIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isIpad ?  ScreenSize.screenWidth/6 : ScreenSize.screenWidth/3.3, height: isIpad ?  ScreenSize.screenWidth/6 : ScreenSize.screenWidth/3.3)
                    .colorMultiply(Color.gray)
                    .clipShape(Circle())
                    .padding(.top, 4)
                    .padding(isIpad ? ScreenSize.screenWidth/20 : ScreenSize.screenWidth/16)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            HStack{
                Text("Nama")
                    .font(isIpad ? .title2 : .headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Tuliskan nama mu...", text: $textInput)
                .font(isIpad ? .title3
                      : .subheadline)
                .multilineTextAlignment(.leading)
                .padding(.leading, 16)
                .padding(.vertical, isIpad ? ScreenSize.screenHeight/60 : ScreenSize.screenHeight/45)
                .frame(maxWidth: .infinity)
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
        }
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/50 : ScreenSize.screenHeight/80)
        .frame(maxWidth: .infinity)
    }
    
    private func showSelectedImageOrPlaceholder(isIpad: Bool) -> some View {
        VStack(alignment: .center) {
            HStack{
                Text("Foto profil")
                    .font(isIpad ? .title2 : .headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Pilih foto profil mu")
                    .font(isIpad ? .title3
                          : .subheadline)
                    .padding(.vertical, isIpad ? ScreenSize.screenHeight/55 : ScreenSize.screenHeight/40)
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
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/15 : ScreenSize.screenHeight/17)
        .frame(maxWidth: .infinity)
    }
    
    private func showRegisterButton(isIpad: Bool) -> some View {
        Button(
            action: {
                homeController.registerAccount(
                    textInput: self.textInput,
                    selectedImage: self.selectedImage,
                    showAlert: $showAlert,
                    alertMessage: $alertMessage
                )
                if !showAlert {
                    self.navToHomeView = true
                }
            },
            label: {
                Text("Selanjutnya")
                    .font(isIpad ? .title2 : .headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, isIpad ? ScreenSize.screenHeight/70 : ScreenSize.screenHeight/60)
                    .frame(maxWidth: .infinity)
            })
        .background(
            Color("redColor(TeWaRa)")
        )
        .cornerRadius(isIpad ? 30 : 25)
        .shadow(radius: 10, y: 4)
        .fullScreenCover(isPresented: $navToHomeView, content: {
            HomeView()
        })
    }
}

#Preview {
    RegisterView()
}
