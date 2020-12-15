//
//  LogInView.swift
//  Flick
//
//  Created by Gruber, John David on 12/12/20.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LogInView: View {
    // MARK: PROPERTIES
    @Binding var showLoginView: Bool
    @Environment(\.presentationMode) var presentationMode


    
    var body: some View {


        
        
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color-2"),Color("Color-1")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            if UIScreen.main.bounds.height > 800 {
                
                Home()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    Home()
                }
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }
       
        
        
    }

    }

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct LogInView_Previews: PreviewProvider {
    @State static var showLogin: Bool = false
    static var previews: some View {
        LogInView(showLoginView: $showLogin)
    }
}

// MARK: - GOOGLE
struct google : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>){
        
    }
}

// ________________________________________________________
// MARK: - HOME
struct Home : View {
    @State  var index = 0

    var body : some View {
        
        VStack{
            
            Image("Logo")
                .resizable()
                .frame(width: 250, height: 125)
            
            HStack{
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        self.index = 0
                    }
                }) {
                Text("Existing")
                    .foregroundColor(self.index == 0 ? .black : .white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .frame(width: (UIScreen.main.bounds.width - 50) / 2 )
                }.background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        self.index = 1
                    }
                }) {
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                } .background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            if self.index == 0{
                
                Login()
            }
            else{
                SignUp()
            }
            
            if self.index == 0{
                Button(action: {
                    
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
            }
            
            HStack(spacing: 15){
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                
                Text("Or")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
            }
            .padding(.top, 10)
            
            HStack{

               google().frame(width:120, height: 50)
             
            }
        }
        .padding()
        .onTapGesture {
            hideKeyboard()
        }
    }
    
}


// MARK: - LOGIN
struct Login : View {
    @State var mail = ""
    @State var pass = ""
    @State var shown = false
    @State var msg = ""
    @State var signInSuccess = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false

    var isLoggedIn: Bool = false
    
    var body : some View {
 
        VStack {
            
            VStack{
                
                HStack(spacing: 15) {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Enter Email Adress", text: self.$mail)
                }.padding(.vertical, 20)
                Divider()
                
                HStack(spacing: 15){
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
        }
        .padding(.vertical)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 25)
        
       Button(action: {
        if self.mail == "" && self.pass == ""{
            self.msg = "Please fill in all details"
            self.shown.toggle()
        
            return
                self.isPresented.toggle()
        }
        
        Auth.auth().signIn(withEmail: self.mail, password: self.pass) { (res, err) in
            if err != nil {
                print((err!.localizedDescription))
                self.msg = err!.localizedDescription
                self.shown.toggle()
                return
            }
            
            self.msg = "Success"
            self.shown.toggle()
            return
                
//            if(self.msg == "Success"){
//                //self.showLoginView.toggle()
//                //self.presentationMode.wrappedValue.dismiss()
//            }
        }
        }) {
            Text("LOGIN")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 100)
        }.background(
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color-2"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
        )
        .cornerRadius(8)
        .offset(y: -40)
        .padding(.bottom, -40)
        .shadow(radius: 15)
        }.alert(isPresented: $shown) {
            return Alert(title: Text(self.msg))
        }
    }
    
}
// MARK: - SIGNUP
struct SignUp : View {
    
    @State var mail = ""
    @State var pass = ""
    @State var repass = ""
    @State var msg = ""
    @State var shown = false

    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
    
    VStack{
        VStack{
            
            HStack(spacing: 15){
                
                Image(systemName: "envelope")
                    .foregroundColor(.black)
                
                TextField("Enter Email Address", text: self.$mail)
            }.padding(.vertical, 20)
            
            Divider()
            HStack(spacing: 15){
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                
                SecureField("Password", text: self.$pass)
                
                Button(action: {
                       
                }) {
                    Image(systemName: "eye")
                        .foregroundColor(.black)
                }
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                
                SecureField("Re-Enter", text: self.$repass)
                
                Button(action: {
                    
                }) {
                    Image(systemName: "eye")
                        .foregroundColor(.black)
                }
            }.padding(.vertical, 20)
        }
        .padding(.vertical)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 25)
        
        
        Button(action: {
            if self.mail == "" && self.pass == ""{
                self.msg = "Please fill in all details"
                self.shown.toggle()
                return
            }
            
            
            
            Auth.auth().createUser(withEmail: self.mail, password: self.pass) { (res, err) in
                if err != nil{
                    print(err!.localizedDescription)
                    self.msg = err!.localizedDescription
                    self.shown.toggle()
                    return
                }
                
                self.msg = "Account Created!"
                self.shown.toggle()
                if(self.msg == "Account Created!"){
                    //self.showLogInView.toggle()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }) {
            Text("SIGNUP")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 100)
        }.background(
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color-2"),Color("Color-1")]), startPoint: .leading, endPoint: .trailing)
        )
        .cornerRadius(8)
        .offset(y: -40)
        .padding(.bottom, -40)
        .shadow(radius: 15)
    }
}
}
