//
//  MainReducer.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import Foundation
import ComposableArchitecture

struct MainReducer: ReducerProtocol, Equatable {
    
    struct State: Equatable {
        var readQuotesFeatureState: ReadQuotesFeature.State
        @PresentationState var addQuoteFeatureState: AddQuoteFeature.State?
    }
    
    enum Action: Equatable {
        case readQuotesAction(ReadQuotesFeature.Action)
        case addButtonTapped
        case addQuoteFeatureAction(PresentationAction<AddQuoteFeature.Action>)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.readQuotesFeatureState, action: /Action.readQuotesAction) {
            ReadQuotesFeature()
        }
        Reduce{ state, action in
            switch action{
            case .addButtonTapped:
                state.addQuoteFeatureState = AddQuoteFeature.State(quote: QuoteModel(id: UUID(), author: "", text: ""))
                return .none
            case .readQuotesAction(_):
                return .none
            case let .addQuoteFeatureAction(.presented(.delegate(.addQuote(quote)))):
                state.readQuotesFeatureState.quotesDB.append(quote)
                return .none
            case .addQuoteFeatureAction(.dismiss):
                return .none
            case .addQuoteFeatureAction(.presented(.addButtonTapped)):
                return .none
            case .addQuoteFeatureAction(.presented(.setText(_))):
                return .none
            case .addQuoteFeatureAction(.presented(.setAuthor(_))):
                return .none
            case .addQuoteFeatureAction(.presented(.setCategory(_))):
                return .none
            case .addQuoteFeatureAction(.presented(.makeFavorite)):
                return .none
            case .addQuoteFeatureAction(.presented(.cancelButtonTapped)):
                return .none
            }
        }
        .ifLet(\.$addQuoteFeatureState, action: /Action.addQuoteFeatureAction){
            AddQuoteFeature()
        }
    }
}
