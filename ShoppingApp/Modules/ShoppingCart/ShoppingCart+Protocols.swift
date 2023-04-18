//
//  ShoppingCart+Protocols.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import Foundation
import UIKit

protocol ShoppingCellProtocol: AnyObject {
    func updateCart(product: ProductModel?)
}

protocol CheckoutProtocol: AnyObject {
    func checkout()
}

//MARK: - ShoppingCellProtocol
extension ShoppingCartController: ShoppingCellProtocol {
    func updateCart(product: ProductModel?) {
        guard let product = product else { return }
        let index = AppConfig.cart.firstIndex(where: { $0.productName == product.productName })
        AppConfig.cart[index ?? 0] = product
        self.viewModel.cart = AppConfig.cart.filter({ $0.quantity ?? 0 > 0 })
        if self.viewModel.cart.isEmpty {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.cartTableView.reloadData()
        }
    }
}

//MARK: - CheckoutProtocol
extension ShoppingCartController: CheckoutProtocol {
    func checkout() {
        let alert = UIAlertController(title: "Checkout completed \(AppConfig.totalPrice.getPriceString())",
                                      message: "Your order is on the way.💜💛",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            AppConfig.resetCart()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
