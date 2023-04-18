//
//  ProductsController+Protocols.swift
//  ShoppingApp
//
//  Created by Güney Köse on 17.04.2023.
//

import Foundation
import UIKit

protocol ProductCellProtocol: AnyObject {
    func productStatusChanged()
}

protocol ProductFooterProtocol: AnyObject {
    func goToCart()
}

protocol ProductDetailProtocol: AnyObject {
    func updateCart(product: ProductModel)
}

//MARK: - ProductCellProtocol Actions
extension ProductsViewController: ProductCellProtocol {
    func productStatusChanged() {
        if let footer = self.productCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).first as? MainFooterView {
            footer.setFooter()
        }
    }
}

//MARK: - ProductDetailProtocol Actions
extension ProductsViewController: ProductDetailProtocol {
    func updateCart(product: ProductModel) {
        self.viewModel.changeQuantity(product: product)
        if let footer = self.productCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).first as? MainFooterView {
            footer.setFooter()
        }
    }
}

//MARK: - ProductFooterProtocol Actions
extension ProductsViewController: ProductFooterProtocol {
    func goToCart() {
        guard AppConfig.totalPrice > Double.zero else { return }
        if let vc = viewModel.shoppingCartStoryboard.instantiateViewController(withIdentifier: ShoppingCartController.id) as? ShoppingCartController {
            vc.setup()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
