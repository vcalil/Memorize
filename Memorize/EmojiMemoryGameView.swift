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
//        VStack {
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//                    ForEach(game.cards) { card in
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            }else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                    game.choose(card: card)
                    }
            }
        })
        .foregroundColor(.red)
        //.font(.largeTitle)
        .padding(.horizontal)
//
//
//                    }
//                }
//            }.foregroundColor(.red)
//        }.padding(.horizontal)
//        Spacer()
//        HStack {
//            Button {
//                shuffle(model: game)
//            } label: {
//                    //Image(systemName: "minus.circle")
//                    Text("Shuffle")
//                }
//        }
//        .font(.largeTitle)
//        .padding(.horizontal)

    }
    
    func shuffle(model: EmojiMemoryGame) {
        model.shuffle(cards: model.cards)
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width , size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
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
