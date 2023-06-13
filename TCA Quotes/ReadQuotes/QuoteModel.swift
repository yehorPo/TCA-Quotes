//
//  QuoteModel.swift
//  TCA Quotes
//
//  Created by Yehor Podolskyi on 12.06.2023.
//

import Foundation


struct QuoteModel: Identifiable, Equatable {
    
    var id:UUID
    var author:String
    var text:String
    var category:Category = .general
    var isFavorite:Bool = false
    
    enum Category: String, Equatable, CaseIterable{
        case general, myOwn = "My own", ancient
    }
}



