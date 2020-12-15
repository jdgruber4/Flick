//
//  HeaderView.swift
//  Flick
//
//  Created by Gruber, John David on 11/29/20.
//

import SwiftUI

struct HeaderView: View {
    //MARK: - Properties
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack {
            Button(action: {
                playSound(sound: "click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showInfoView.toggle()
            }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
                .accentColor(Color.primary)
                .sheet(isPresented: $showInfoView) {
                InfoView()
                }
                
                Spacer()
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            Spacer()
            
            Button(action: {
                //ACTION
                playSound(sound: "click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showGuideView.toggle()
            }) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            .sheet(isPresented: $showGuideView){
                GuideView()
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuide: Bool = false
    @State static var showInfo: Bool = false
    static var previews: some View {
        HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height:50))
    }
}
