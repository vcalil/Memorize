//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Galil on 19/08/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene{
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
