//
//  Double++.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import Foundation

extension Double {
    /**
     Creates price string.
     */
    func getPriceString() -> String {
        let formattedPrice = String(format: "%.2f", self)
        return String(describing: formattedPrice) + "₺"
    }
}
