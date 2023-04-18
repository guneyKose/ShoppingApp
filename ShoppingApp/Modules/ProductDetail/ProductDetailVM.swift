//
//  ProductDetailVM.swift
//  ShoppingApp
//
//  Created by Güney Köse on 17.04.2023.
//

import Foundation

final class ProductDetailVM {
    let title = "Product Detail"
    let buttonTitle = "Update Cart"
    
    var product: ProductModel?
    
    lazy var quantity: Int = 0
    lazy var totalPrice: Double = AppConfig.totalPrice
    
    func changeQuantity(isIncrease: Bool) {
        if isIncrease {
            totalPrice += product?.productPrice ?? 0
        } else {
            totalPrice -= product?.productPrice ?? 0
        }
    }
}
