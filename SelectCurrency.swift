//
//  SelectCurrency.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 28/08/2024.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            // Parchment background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            
            VStack {
                // Select starting currency
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                IconGrid(currency: $topCurrency)
                
                // Select currency to convert to
                Text("Select the currency you would like to convert to:")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                IconGrid(currency: $bottomCurrency)
                
                // Done Button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(topCurrency: .constant(.copperPenny), bottomCurrency: .constant(.silverPiece))
}
