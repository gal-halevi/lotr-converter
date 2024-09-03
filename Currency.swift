//
//  Currency.swift
//  LOTRConverter17
//
//  Created by Gal Halevi on 29/08/2024.
//
import Foundation
import SwiftUI

enum Currency: Double, CaseIterable, Identifiable, Codable {
    case libertyPiece = 32000
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        case .libertyPiece:
                .libertypiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        case .libertyPiece:
            "Liberty Piece"
        }
    }
    
    func convert(_ stringAmount: String, to currency: Currency) -> String {
        guard let doubleAmount = Double(stringAmount) else { return "" }
        let convertedAmount = doubleAmount * currency.rawValue / self.rawValue
        
        if convertedAmount == floor(convertedAmount) {
            return String(format: "%.0f", convertedAmount)
        }
        return String(format: "%.2f", convertedAmount)
    }
}
