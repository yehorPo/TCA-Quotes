//
//  AddQuoteFeature.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import Foundation
import ComposableArchitecture



struct AddQuoteFeature: ReducerProtocol{
    struct State: Equatable {
        var quote: QuoteModel
    }
    enum Action: Equatable {
        case addButtonTapped
        case setText(String)
        case setAuthor(String)
        case setCategory(QuoteModel.Category)
        case makeFavorite
        case delegate(Delegate)
        case cancelButtonTapped
      
        enum Delegate: Equatable {
            case addQuote(QuoteModel)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action{
        case .addButtonTapped:
            return .run { [quote = state.quote] send in
                await send(.delegate(.addQuote(quote)))
                await self.dismiss()
            }
        case .setText(let text):
            state.quote.text = text
            return .none
        case .setAuthor(let author):
            state.quote.author = author
            return .none
        case .setCategory(let category):
            state.quote.category = category
            return .none
        case .makeFavorite:
            state.quote.isFavorite.toggle()
            return .none
        case .delegate(_):
            return .none
        case .cancelButtonTapped:
            return .run{ _ in await self.dismiss()}
        }
    }
    
}
