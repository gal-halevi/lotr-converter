//
//  VStackCurrency.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 04/09/2024.
//

import SwiftUI

struct VStackCurrency: View {
    let currency: Currency
    @Binding var amount: String
    @Binding var showSelectCurrency: Bool
    @FocusState.Binding var focusTyping: Bool
    let rightAlignment: Bool
    
    func getCurrencyImage() -> AnyView{
        AnyView(Image(self.currency.image)
            .resizable()
            .scaledToFit()
            .frame(height: 33))
    }
    
    func getCurrencyName() -> AnyView {
        AnyView(Text(self.currency.name)
            .font(.headline)
            .foregroundStyle(.white))
        
    }
    
    var body: some View {
        let rightAlignmentList: [() -> AnyView] = [getCurrencyImage, getCurrencyName]
        let leftAlignmentList: [() -> AnyView] = [getCurrencyName, getCurrencyImage]
        VStack {
            HStack {
                let iterationList = rightAlignment ? rightAlignmentList : leftAlignmentList
                ForEach(iterationList.indices, id: \.self) { index in
                    iterationList[index]()
                }
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(rightAlignment ? .trailing : .leading)
                .focused($focusTyping)
                .keyboardType(.decimalPad)
        }
    }
}

//#Preview {
//    VStackCurrency(currency: Currency, amount: <#Binding<String>#>, showSelectCurrency: <#Binding<Bool>#>)
//}
