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
        ScrollView{
            VStack(alignment: .center){
                setUpRegisterView()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Oops..."),
                message: Text("Anda lupa memasukkan foto profil."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func setUpRegisterView() -> some View {
        VStack {
            self.logo()
            self.greetings()
            self.showTextInputField()
            self.showSelectedImageOrPlaceholder()
            self.showRegisterButton()
        }
        .padding(.vertical, UIDevice.current.userInterfaceIdiom == .phone ? 20 : 30)
    }
    
    private func logo() -> some View {
        Image("logo(TeWaRa)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 150 : 250)
            .padding(.bottom, 10)
    }
    
    private func greetings() -> some View {
        Text("Halo, Sobat TeWaRa!")
            .font(UIDevice.current.userInterfaceIdiom == .phone ? .title : .largeTitle)
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
                        .font(UIDevice.current.userInterfaceIdiom == .phone ? .title : .largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                )
            )
            .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 40 : 80)
    }
    
    private func showTextInputField() -> some View {
        VStack(alignment: .center) {
            // Display the selected image or placeholder
            if let imageData = selectedImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 120 : 140, height: UIDevice.current.userInterfaceIdiom == .phone ? 120 : 140)
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
                    .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 25 : 40)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Image("profilePictureIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 120 : 140, height: UIDevice.current.userInterfaceIdiom == .phone ? 120 : 140)
                    .colorMultiply(Color.gray)
                    .clipShape(Circle())
                    .padding(.top, 4)
                    .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 25 : 40)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            HStack{
                Text("Nama")
                    .font(UIDevice.current.userInterfaceIdiom == .phone ? .headline : .title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer().frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 275 : 685)
            }
            TextField("Tuliskan nama mu...", text: $textInput)
                .font(UIDevice.current.userInterfaceIdiom == .phone ? .subheadline
                      : .title3)
                .multilineTextAlignment(.leading)
                .padding(.leading, 16)
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 320 : .infinity, height: 60)
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
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 0 : 20)
        }
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 10 : 40)
        .frame(maxWidth: .infinity)
    }
    
    private func showSelectedImageOrPlaceholder() -> some View {
        VStack(alignment: .center) {
            HStack{
                Text("Foto profil")
                    .font(UIDevice.current.userInterfaceIdiom == .phone ? .headline : .title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer().frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 240 : 640)
            }
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Pilih foto profil mu")
                    .font(UIDevice.current.userInterfaceIdiom == .phone ? .subheadline
                          : .title3)
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 320 : 740, height: 60)
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
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 40 : 150)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func showRegisterButton() -> some View {
        Button(
            action: {
                homeController.registerAccount(textInput: self.textInput, selectedImage: self.selectedImage, showAlert: $showAlert)
                if !showAlert {
                    self.navToHomeView = true
                }
            },
            label: {
                Text("Selanjutnya")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 24, weight: .heavy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 325 : 780, height: UIDevice.current.userInterfaceIdiom == .phone ? 44 : 55)
            })
        .background(
            Color("redColor(TeWaRa)")
        )
        .cornerRadius(UIDevice.current.userInterfaceIdiom == .phone ? 20 : 30)
        .frame(width: 100, height: 50)
        .shadow(radius: 10, y: 4)
        .fullScreenCover(isPresented: $navToHomeView, content: {
            HomeView()
        })
    }
}

#Preview {
    RegisterView()
}
