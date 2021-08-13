//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Galil on 17/07/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        let shuffled = viewModel.cards.shuffled()
        return HStack(content:  {
            ForEach(shuffled, content: { card in
                CardView(card: card).aspectRatio(0.45, contentMode: .fit).onTapGesture{
                    viewModel.choose(card: card)
                }
            })
        })
        .foregroundColor(.orange)
        .padding()
  
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View{
            return ZStack(content: {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                }else{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            })
            .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height)*0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
