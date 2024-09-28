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
    let emojis: [String] = ["🤖", "👹", "👾", "😈", "🤠"] // Or Array<String>
    
    var body: some View {
        HStack { // Trailing closure syntax
            // 0..<5, 0...5 from 0 up to and including 5; ForEach View
            ForEach(emojis.indices, id: \.self) { index in // Arguments to closures
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.cyan)
        .padding()
    }
}

struct CardView: View { // Views are immutable (!!); you need backend to change
    var content: String = ""
    @State // Creating a pointer to the variable, making the variable itself mutable
    var isFaceUp: Bool = true // Set a default value; can be a constant if it is only set once
    
    var body: some View {
        // Trailing closure syntax; @ViewBuilder allows limited content, can't do for-loop
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/) // Local variable; type inference
            
            if isFaceUp {
                base
                    .fill(.white)
                base // No way to both stroke and fill a shape (!)
                    .strokeBorder(lineWidth: 3) // Order matters (!)
                Text(content)
                    .font(.largeTitle)
            } else {
                base
                    .fill() // Fill or stroke. Fill is default
            }
        }.onTapGesture { // View Modifier; normal code, no longer a @ViewBuilder
            // print("tapped") // Print to console
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
