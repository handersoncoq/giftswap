//
//  GiftProtocol.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/15/25.
//


import Foundation

protocol GiftProtocol {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
    var category: GiftCategory { get }
    var imageURLs: [String]? { get }
    var storeLink: String? { get }
}
