//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by Güney Köse on 15.04.2023.
//

import Foundation

struct ProductModel: Codable {
    let productName: String?
    let productDescription: String?
    let productPrice: Double?
    let productImage: String?
    var quantity: Int? //Custom data.
}
