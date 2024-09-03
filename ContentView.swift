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
        if let leftData = UserDefaults.standard.data(forKey: "leftCurrency") {
            do {
                let decoder = JSONDecoder()
                let decodedCurrency = try decoder.decode(Currency.self, from: leftData)
                self._leftCurrency = State(initialValue: decodedCurrency)
            } catch {
                print("Unable to decode \(leftCurrency)")
            }
        }
        
        if let rightData = UserDefaults.standard.data(forKey: "rightCurrency") {
            do {
                let decoder = JSONDecoder()
                let decodedCurrency = try decoder.decode(Currency.self, from: rightData)
                self._rightCurrency = State(initialValue: decodedCurrency)
            } catch {
                print("Unable to decode \(rightCurrency)")
            }
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
                    // Left currency
                    VStack {
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        
                        // Amount text box
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Equal sign text
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .symbolEffect(.pulse)
                    
                    // Right currency
                    VStack {
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        // Amount text box
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
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
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.leftCurrency)
                UserDefaults.standard.set(data, forKey: "leftCurrency")
            } catch {
                print("Unable to encode \(leftCurrency)")
            }
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.rightCurrency)
                UserDefaults.standard.set(data, forKey: "rightCurrency")
            } catch {
                print("Unable to encode \(rightCurrency)")
            }
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
