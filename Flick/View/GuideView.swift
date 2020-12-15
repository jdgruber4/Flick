//
//  GuideView.swift
//  Flick
//
//  Created by Gruber, John David on 11/30/20.
//

import SwiftUI

struct GuideView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        VStack(alignment: .center, spacing: 20) {
            HeaderComponent()
            
            Spacer(minLength: 10)
            
            
            Text("Get Started!")
                .fontWeight(.black)
                .modifier(TitleModifier())
            
            Text("Take the guess work out of finding something to watch on Netflix and flick through the catalog till you match!")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 10)
            
            VStack(alignment: .leading, spacing: 25) {
                GuideComponent(title: "Like",
                               subtitle: "Swipe right",
                               description: "Do you want to watch this film? Touch the screen and swipe right. It will be saved to your favorites",
                               icon: "heart.circle")
                GuideComponent(title: "Dismiss",
                               subtitle: "swipe left",
                               description: "Is this selection not for you? Touch the screen and swipe left. This selection will no longer be presented to you",
                               icon: "xmark.circle")
                GuideComponent(title: "watch",
                               subtitle: "Tap the button",
                               description: "Youve made your choice now get ready to watch!!",
                               icon: "checkmark.square")
            }
            
            Spacer(minLength: 10)
            
            Button(action: {
                //Action
                //print("a button was tapped")
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
struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}

