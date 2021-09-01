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
            gamebody
            shuffle
        }
        .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var gamebody: some View {
//        VStack {
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//                    ForEach(game.cards) { card in
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio, content: { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                //Rectangle().opacity(0)
                Color.clear
            }else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 3)))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card: card)
                        }
                    }
            }
        })
        .onAppear {
            // "deal" cards
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .foregroundColor(CardConstants.color)
        //.font(.largeTitle)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
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

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    //.font(font(in: geometry.size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
//    private func font(in size: CGSize) -> Font {
//        Font.system(size: min(size.width , size.height) * DrawingConstants.fontScale)
//    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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
