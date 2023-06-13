//
//  TCA_QuotesApp.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import SwiftUI
import ComposableArchitecture


@main
struct TCA_QuotesApp: App {
    var body: some Scene {
        WindowGroup {
            let quotesDB = [
                QuoteModel(id: UUID(), author: "I'm", text: "Lol is lol", category: .myOwn, isFavorite: true),
                QuoteModel(id: UUID(), author: "H.L.", text: "That is not dead which can eternal lie", category: .ancient, isFavorite: false),
                QuoteModel(id: UUID(), author: "Eminem", text: "Chicky-chicky slim shady", category: .general, isFavorite: true)
            ]
            ContentView(store: Store(initialState: MainReducer.State(readQuotesFeatureState: ReadQuotesFeature.State(quotesDB: quotesDB)), reducer: {
                MainReducer()
            }))
        }
    }
}
