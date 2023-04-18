//
//  ShoppingCartVM.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import Foundation
import UIKit

final class ShoppingCartVM {
    
    lazy var cart: [ProductModel] = []
    lazy var footerHeight: CGFloat = 120
    lazy var nib: UINib = { return UINib(nibName: ShoppingCartCell.id, bundle: nil) }()
    lazy var footerNib: UINib = { return UINib(nibName: CheckoutFooter.id, bundle: nil) }()
}

