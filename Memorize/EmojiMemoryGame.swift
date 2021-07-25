//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Galil on 25/07/21.
//

import SwiftUI



class EmojiMemoryGame {
    private var model: MemoryGame<String> = creatMemoryGame()
    
    static func creatMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in
            return emojis[pairIndex]
            }
        
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choos(card: card)
    }
}
