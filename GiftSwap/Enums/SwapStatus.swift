//
//  GiftSwapStatus.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

enum SwapStatus: String, Codable {
    case available
    case inBasket
    case matched
    case swapped
    case notListed
    case pending
}
