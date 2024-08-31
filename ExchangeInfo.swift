//
//  ExchangeInfo.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 27/08/2024.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Exchange Rates title
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                // Exchange text block
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                
                // Exchange rates
                ExchangeRate(leftImage: .goldpiece, currencyText: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
                ExchangeRate(leftImage: .goldpenny, currencyText: "1 Gold Penny = 4 Silver Pieces", rightImage: .silverpiece)
                ExchangeRate(leftImage: .silverpiece, currencyText: "1 Silver Piece = 4 Silver Pennies", rightImage: .silverpenny)
                ExchangeRate(leftImage: .silverpenny, currencyText: "1 Silver Penny = 100 Copper Pennies", rightImage: .copperpenny)
                
                // Done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}
