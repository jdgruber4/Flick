//
//  GuideComponent.swift
//  Flick
//
//  Created by Gruber, John David on 11/30/20.
//

import SwiftUI

struct GuideComponent: View {
    var title: String
    var subtitle: String
    var description: String
    var icon: String
    
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.orange)
            
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title.uppercased())
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
                Text(subtitle.uppercased())
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.orange)
            }
            Divider().padding(.bottom, 4)
            Text(description)
                .font(.footnote)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct GuideComponent_Previews: PreviewProvider {
    static var previews: some View {
        GuideComponent(
            title: "Title",
            subtitle: "swipe right",
            description: "This is a placeholder sentence. This is a place holder sentence, this is a place holder sentence",
            icon: "heart.circle")
            .previewLayout(.sizeThatFits)
    }
}
