//
//  ContentView.swift
//  Memorize
//
//  Created by Galil on 17/07/21.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        let shuffled = viewModel.cards.shuffled()
        return HStack(content:  {
            ForEach(shuffled, content: { card in
                CardView(card: card).onTapGesture{
                    viewModel.choose(card: card)
                }
            })
        })
        .foregroundColor(.orange)
        .padding()
        .font(.largeTitle)
            
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        return ZStack(content: {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            }else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
