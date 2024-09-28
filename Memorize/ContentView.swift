//
//  ContentView.swift
//  Memorize
//
//  Created by Jackie Yang on 9/28/24.
//

// Hold Optional key and click to see the type of something
// Swift is strongly typed language

import SwiftUI

struct ContentView: View { // Not OOP at all. This struct behaves like a View
    let emojis: [String] = ["🤖", "👹", "👾", "😈", "🤠", "👺", "🎃", "💩"] // Or Array<String>
    
    @State // Not frequently used in real-code, good for demos
    var cardCount: Int = 4
    
    var body: some View { // Computed View
        VStack { // This is a @ViewBuilder
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding() // This is for VStack itself, not recursively applied
    }
    
    var cards: some View { // Implicit return
        
        // Trailing closure syntax
        // Making things in it as small as possible
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            // 0..<5, 0...5 from 0 up to and including 5; ForEach View
            ForEach(0..<cardCount, id: \.self) { index in // Arguments to closures
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
    }
    
    // by is the external param name, offset is the internal param name
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View { // Views are immutable (!!); you need backend to change
    var content: String = ""
    @State // Creating a pointer to the variable, making the variable itself mutable
    var isFaceUp: Bool = true // Set a default value; can be a constant if it is only set once
    
    var body: some View {
        // Trailing closure syntax; @ViewBuilder allows limited content, can't do for-loop
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 15) // Local variable; type inference
            
            Group { // Like a ForEach of 1, allows applying properties to group of Views
                base
                    .fill(.white)
                base // No way to both stroke and fill a shape (!)
                    .strokeBorder(lineWidth: 3) // Order matters (!)
                Text(content)
                    .font(.largeTitle)
            }
//            .opacity(isFaceUp ? 1 : 0)
            // Opacity is good way to toggle visibility without impacting spacing
            
            // Fill it with foreground color if isFaceUp is false
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture { // View Modifier; normal code, no longer a @ViewBuilder
            // print("tapped") // Print to console
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
