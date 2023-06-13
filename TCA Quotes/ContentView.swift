//
//  ContentView.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import SwiftUI
import ComposableArchitecture
struct ContentView: View {
    
    var store:StoreOf<MainReducer>
    
    var body: some View {
        WithViewStore(store , observe: {$0}) { viewStore in
            NavigationView {
                    AllQuotesView(store: Store(initialState: viewStore.readQuotesFeatureState, reducer: {
                        ReadQuotesFeature()
                    }))
                    .toolbar {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                    .sheet(store: self.store.scope(state: \.$addQuoteFeatureState, action: { .addQuoteFeatureAction($0) })) { addContactStore in
                        NavigationStack{
                            AddQuoteView(store: addContactStore)
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
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
