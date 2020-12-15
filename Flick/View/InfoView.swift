//
//  InfoView.swift
//  Flick
//
//  Created by Gruber, John David on 12/1/20.
//

import SwiftUI

struct InfoView: View {
    // MARK: -PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
        VStack {
            HeaderComponent()
            
            Spacer(minLength: 10)
            
            Text("App Info")
                .fontWeight(.black)
                .modifier(TitleModifier())
            
            AppInfoView()
            
            Text("Credits")
                .fontWeight(.black)
                .modifier(TitleModifier())
            
            CreditsView()
            
            Spacer(minLength: 10)
            
            Button(action: {
            //ACTION
                //print("A button was tapped")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Continue".uppercased())
                    .modifier(ButtonModifier())
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 15)
        .padding(.bottom, 25)
        .padding(.horizontal, 25)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RowAppInfoView(ItemOne: "Application", ItemTwo: "Flick")
            RowAppInfoView(ItemOne: "Compatibility", ItemTwo: "Iphone and Ipad")
            RowAppInfoView(ItemOne: "Developer", ItemTwo: "JD Gruber")
            RowAppInfoView(ItemOne: "Course", ItemTwo: "CPSC 315: IOS App Development")
            RowAppInfoView(ItemOne: "Professor", ItemTwo: "Dr. Gina Sprint")
            RowAppInfoView(ItemOne: "Version", ItemTwo: "1.0.0")
        }
    }
}

struct RowAppInfoView: View {
    //MARK: - Properties
    var ItemOne: String
    var ItemTwo: String
    var body: some View {
        VStack {
            HStack {
                Text(ItemOne).foregroundColor(Color.gray)
                Spacer()
                Text(ItemTwo)
            }
            Divider()
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Photos").foregroundColor(Color.gray)
                Spacer()
                Text("Unsplash")
            }
            
            Divider()
            
            Text("API's").foregroundColor(Color.gray)
            Text("uNoAPI, FirebaseAPI, Google login")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .font(.footnote)
        }
    }
}
