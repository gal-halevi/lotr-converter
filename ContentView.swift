//
//  ContentView.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 25/08/2024.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @AppStorage("showExchangeInfo") var showExchangeInfo = false
    @AppStorage("showSelectCurrency") var showSelectCurrency = false
    
    @AppStorage("leftAmount") var leftAmount = ""
    @AppStorage("rightAmount") var rightAmount = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    init() {
        if let leftCurrency = getUserDefaultsCurrencyObj(forKey: "leftCurrency") {
            self._leftCurrency = State(initialValue: leftCurrency)
        }
        if let rightCurrency = getUserDefaultsCurrencyObj(forKey: "rightCurrency") {
            self._rightCurrency = State(initialValue: rightCurrency)
        }
    }
    
    func getUserDefaultsCurrencyObj(forKey: String) -> Currency? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            do {
                let decoder = JSONDecoder()
                let decodedCurrency = try decoder.decode(Currency.self, from: data)
                return decodedCurrency
            } catch {
                print("Unable to decode \(forKey)")
            }
        }
        return nil
    }
    
    func setUserDefaultsCurrencyObj(currency: Currency, forKey: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(currency)
            UserDefaults.standard.set(data, forKey: forKey)
        } catch {
            print("Unable to encode \(currency)")
        }
    }
    
    var body: some View {
        ZStack {
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                // Pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                // Currency Exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Currency Exchange section
                HStack {
                    VStackCurrency(currency: leftCurrency,
                                   amount: $leftAmount,
                                   showSelectCurrency: $showSelectCurrency,
                                   focusTyping: $leftTyping,
                                   rightAlignment: false)
                    
                    // Equal sign text
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .symbolEffect(.pulse)
                    
                    VStackCurrency(currency: rightCurrency,
                                   amount: $rightAmount,
                                   showSelectCurrency: $showSelectCurrency,
                                   focusTyping: $rightTyping,
                                   rightAlignment: true)
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                .onTapGesture() {}
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
            }
            //            .border(.blue)
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            setUserDefaultsCurrencyObj(currency: leftCurrency, forKey: "leftCurrency")
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            setUserDefaultsCurrencyObj(currency: rightCurrency, forKey: "rightCurrency")
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .onTapGesture {
            leftTyping = false
            rightTyping = false
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}
