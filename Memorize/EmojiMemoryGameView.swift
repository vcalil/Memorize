//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Galil on 17/07/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    
    //@State var length = viewModel.cards
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture{
                            game.choose(card: card)
                        }
                        
                    }
                }
            }.foregroundColor(.red)
        }.padding(.horizontal)
        Spacer()
        HStack {
            Button {
                shuffle(model: game)
            } label: {
                    Image(systemName: "minus.circle")
                }
        }
        .font(.largeTitle)
        .padding(.horizontal)

    }
    
    func shuffle(model: EmojiMemoryGame) {
        model.shuffle(cards: model.cards)
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }else if card.isMatched {
                shape.opacity(0)
            }else {
                shape.fill()
            }
        }
    }
}
/*
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
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}
