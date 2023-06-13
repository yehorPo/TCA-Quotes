//
//  AllQuotesView.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import SwiftUI
import ComposableArchitecture


struct AllQuotesView: View {
    
    var store:StoreOf<ReadQuotesFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.quotesList) { viewStore in
            NavigationStack{
                Text("Categories:")
                HStack{
                    Button {
                        viewStore.send(.filterByFavoritesTapped)
                    } label: {
                        Image(systemName: "heart.fill")
                    }.buttonStyle(.bordered)
                    Button {
                        viewStore.send(.showAllTapped)
                    } label: {
                        Text("All")
                    }.buttonStyle(.bordered)
                    Button {
                        viewStore.send(.filterByGeneralTapped)
                    } label: {
                        Text("General")
                    }.buttonStyle(.bordered)
                    Button {
                        viewStore.send(.filterByMyOwnTapped)
                    } label: {
                        Text("My own")
                    }.buttonStyle(.bordered)
                    Button {
                        viewStore.send(.filterByAncientTapped)
                    } label: {
                        Text("Ancient")
                    }.buttonStyle(.bordered)

                }
                List{
                    ForEach(viewStore.state) { quote in
                        VStack {
                            HStack{
                                Text(quote.text).font(.title3).bold()
                                Spacer()
                                Text("Author: \(quote.author)")
                                
                            }
                            Divider()
                            Text("Category: \(quote.category.rawValue.capitalized)")
                            Button {
                                viewStore.send(.favoriteButtonTapped(quote.id))
                            } label: {
                                Image(systemName: quote.isFavorite ? "heart.fill" : "heart").foregroundColor(.gray)
                            }.padding()

                        }
                    }
                }
                
                .navigationTitle("All Quotes")
            }
        }
    }
}

struct AllQuotesView_Previews: PreviewProvider {
    static var previews: some View {
        let quotesDB = [
            QuoteModel(id: UUID(), author: "I'm", text: "Lol is lol", category: .myOwn, isFavorite: true),
            QuoteModel(id: UUID(), author: "H.L.", text: "That is not dead which can eternal lie", category: .ancient, isFavorite: false),
            QuoteModel(id: UUID(), author: "Eminem", text: "Chicky-chicky slim shady", category: .general, isFavorite: true)
        ]
        AllQuotesView(store: Store(initialState: ReadQuotesFeature.State(quotesDB: quotesDB), reducer: {
            ReadQuotesFeature()
        }))
    }
}
