//
//  ReadQuotesFeature.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import Foundation
import ComposableArchitecture


struct ReadQuotesFeature: ReducerProtocol,Equatable {
    struct State: Equatable{
        var categoryToShow:Category? = .none
        var quotesDB:[QuoteModel] = []
        var quotesList:[QuoteModel] = []
    }
    enum Action: Equatable{
        case favoriteButtonTapped(UUID)
        case filterByFavoritesTapped
        case filterByGeneralTapped
        case filterByMyOwnTapped
        case filterByAncientTapped
        case showAllTapped
    }
    func reduce(into state: inout State, action: Action) -> EffectTask<Action>{
        switch action{
        case let .favoriteButtonTapped(id):
            let indexOfTappedQuote = state.quotesDB.firstIndex { quote in
                quote.id == id
            }
            if let safeIndex = indexOfTappedQuote{
                state.quotesList[safeIndex].isFavorite.toggle()
                state.quotesDB[safeIndex].isFavorite.toggle()
            }
            return .none
        case .filterByFavoritesTapped:
            var favoritesArray:[QuoteModel] = []
            for quote in state.quotesDB {
                if quote.isFavorite {
                    favoritesArray.append(quote)
                }
            }
            state.quotesList = favoritesArray
            return .none
        case .filterByGeneralTapped:
            var generalArray:[QuoteModel] = []
            for quote in state.quotesDB {
                if quote.category == .general {
                    generalArray.append(quote)
                }
            }
            state.quotesList = generalArray
            return .none
        case .filterByMyOwnTapped:
            var myOwnArray:[QuoteModel] = []
            for quote in state.quotesDB {
                if quote.category == .myOwn {
                    myOwnArray.append(quote)
                }
            }
            state.quotesList = myOwnArray
            return .none
        case .filterByAncientTapped:
            var ancientArray:[QuoteModel] = []
            for quote in state.quotesDB {
                if quote.category == .ancient {
                    ancientArray.append(quote)
                }
            }
            state.quotesList = ancientArray
            return .none
        case .showAllTapped:
            state.quotesList = state.quotesDB
            return .none
        }
    }
    
}
