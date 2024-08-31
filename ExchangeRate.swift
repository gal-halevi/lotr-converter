//
//  ExchangeRate.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 27/08/2024.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let currencyText: String
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
            // Gold piece to pennies
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(currencyText)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Gold penny to silver pieces
            
            // Silver piece to silver pennies
            
            // Silver penny to copper pennies
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, currencyText: "Foo", rightImage: .goldpenny)
}
