//
//  ContentView.swift
//  Flick
//
//  Created by Gruber, John David on 11/28/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @State var showLogin: Bool = false
    @State var counter: Int = 1
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65.0
    

    
    
    //MARK: - CARD VIEWSs
    //array of cardViwes containing films
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        //only display 2 cardViews to decrease load
        for index in 0..<2 {
            views.append(CardView(flick: filmData[index]))
        }
        return views
    }()
    
    // MARK: MOVE CARD
    
    private func moveCards() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        
        let flick = filmData[lastCardIndex % filmData.count]
        
        let newCardView = CardView(flick: flick)
        
        cardViews.append(newCardView)
    }
    

    
    // MARK: - TOP CARD
    //reorder cards so the first indexed card appears first
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    
    //MARK: - DRAG STATES
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
 
    var body: some View {
        

        
        VStack {
            //MARK: - HEADER
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            Spacer()
            
            //MARK: - CARDS
            ZStack {
                //ForEach grabs the last element in the card stack
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                // X-Symbol
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    //set opacity of symbol based upon the location of the topCard
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                //Heart-symbol
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                 
                            }
                        )
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 12) : 0))
                        //smoothes dragging animation after release
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        //the user must press onb the screen for 0.01 seconds for the gesture to recognize
                        //ajusts dragState after time
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                                    .sequenced(before: DragGesture())
                                    .updating(self.$dragState, body: { (value, state, transaction) in
                                        switch value {
                                        case .first(true):
                                            state = .pressing
                                        case .second(true, let drag):
                                            state = .dragging(translation: drag?.translation ?? .zero)
                                        default:
                                            break
                                        }
                                    })
                                    //removal transition for card
                                    .onChanged({(value) in
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        if drag.translation.width < -self.dragAreaThreshold {
                                            self.cardRemovalTransition = .leadingBottom
                                        }
                                        if drag.translation.width > self.dragAreaThreshold {
                                            self.cardRemovalTransition = .trailingBottom
                                        }
                                    })
                                    // remove the cardView stack if the card is moved more than 65px form standard otherwise snap back to origonal position
                                    .onEnded({(value) in
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                            playSound(sound: "swipe", type: "mp3")
                                            self.moveCards()
                                        }
                                    })
                        ).transition(self.cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            
            
            // MARK: - FOOTER
            FooterView(showWatchAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
        //MARK: - LOGIN
        .onAppear(perform: {
            if(self.counter == 1){
                self.counter += 1
                self.showLogin = true

            }
        })
        .sheet(isPresented: $showLogin) {

            LogInView(showLoginView: $showLogin)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
        
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("SUCCESS"),
                message: Text("Enjoy your netflix experience!"), dismissButton: .default(Text("Enjoy!")))
        }
    }
    
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
