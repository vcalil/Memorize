//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Galil on 25/07/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published var model = creatMemoryGame()
    
    private static func creatMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷","🧟‍♂️","☠️","🕸"]
        //let numberOfCards = Int.random(in: 2...6)
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
            }
        
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffleCards()
    }
    
    func restart() {
        model = EmojiMemoryGame.creatMemoryGame()
    }
}
