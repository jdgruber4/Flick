//
//  FooterView.swift
//  Flick
//
//  Created by Gruber, John David on 11/29/20.
//

import SwiftUI

struct FooterView: View {
    //MARK: - PROPERTIES
    @Binding var showWatchAlert: Bool
    let haptics = UINotificationFeedbackGenerator()
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light))
            
            Spacer()
            
            Button(action: {
            //ACTION
                playSound(sound: "click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showWatchAlert.toggle()
            }) {
                Text("Watch".uppercased())
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .accentColor(Color.orange)
                    .background(
                        Capsule().stroke(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color-2"),Color("Color-1")]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                    )
            }
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 42, weight: .light))
            
        }
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    @State static var showAlert: Bool = false
    static var previews: some View {
        FooterView(showWatchAlert: $showAlert)
            .previewLayout(.fixed(width: 375, height:80))
    }
}
