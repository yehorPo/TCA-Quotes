//
//  AddQuoteView.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import SwiftUI
import ComposableArchitecture

struct AddQuoteView: View {
    
    var store: StoreOf<AddQuoteFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.quote) { viewStore in
            Form{
                Section{
                    TextField("Quote", text: viewStore.binding(get: \.text, send: {.setText($0)}))
                    TextField("Author", text: viewStore.binding(get: \.author, send: {.setAuthor($0)}))
                    Picker("Category", selection: viewStore.binding(get: \.category, send: {.setCategory($0)})) {
                        ForEach(QuoteModel.Category.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(Optional(category))
                        }
                    }
                    Toggle("Favotite", isOn: viewStore.binding(get: \.isFavorite, send: .makeFavorite))
                }
                Button("Save quote"){
                    viewStore.send(.addButtonTapped)
                }
                Button("Cancel"){
                    viewStore.send(.cancelButtonTapped)
                }
            }
        }
    }
}

struct AddQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuoteView(store: Store(initialState: AddQuoteFeature.State(quote: QuoteModel(id: UUID(), author: "", text: "")), reducer: {
            AddQuoteFeature()
        }))
    }
}
