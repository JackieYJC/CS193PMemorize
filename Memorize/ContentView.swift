//
//  ContentView.swift
//  Memorize
//
//  Created by Jackie Yang on 9/28/24.
//

import SwiftUI

struct ContentView: View { // not OOP at all. This struct behaves like a View
    
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
        }
        .foregroundColor(.cyan)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false // has to have a value (initialize)
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 25.0) // no way to both stroke and fill a shape (!)
                    .strokeBorder(lineWidth: 3) // order matters
                Text("🐶")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    ContentView()
}
