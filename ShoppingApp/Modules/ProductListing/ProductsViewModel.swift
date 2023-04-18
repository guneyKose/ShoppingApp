//
//  MainViewModel.swift
//  ShoppingApp
//
//  Created by Güney Köse on 15.04.2023.
//

import Foundation
import UIKit

final class ProductsViewModel {
    
    private var baseURLString = "https://mocki.io/v1/6bb59bbc-e757-4e71-9267-2fee84658ff2"
    
    lazy var productDetailStoryboard = UIStoryboard(name: "ProductDetail", bundle: nil)
    lazy var shoppingCartStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
    
    lazy var nib: UINib = { return UINib(nibName: ProductCell.id, bundle: nil) }()
    lazy var footerNib: UINib = { return UINib(nibName: MainFooterView.id, bundle: nil) }()
    lazy var products: [ProductModel] = []
    
    private lazy var leftInset: CGFloat = { return 24 }()
    private lazy var rightInset: CGFloat = { return 24 }()
    private lazy var topInset: CGFloat = { return 24 }()
    private lazy var bottomInset: CGFloat = { return 10 }()
    private lazy var minimumInteritemSpacing: CGFloat = { return 0 }()
    private lazy var minimumLineSpacing: CGFloat = { return 20 }()
    
    public func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = self.minimumInteritemSpacing
        layout.minimumLineSpacing = self.minimumLineSpacing
        layout.sectionInset.top = self.topInset
        layout.sectionInset.bottom = self.bottomInset
        layout.sectionInset.left = self.leftInset
        layout.sectionInset.right = self.rightInset
        layout.sectionFootersPinToVisibleBounds = true
        return layout
    }

    /**
     Fetch data from API
     */
    public func fetchProducts(_ completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: self.baseURLString) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if let error {
                        debugPrint(error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(false)
                        }
                        return
                    }
                    if let data = data {
                        let decoder = JSONDecoder()
                       do {
                           let decodedData = try decoder.decode([ProductModel].self, from: data)
                           self.products += decodedData
                           DispatchQueue.main.async {
                               self.setupCart()
                               completion(true)
                           }
                       } catch let error {
                           debugPrint(error.localizedDescription)
                           DispatchQueue.main.async {
                               completion(false)
                           }
                           return
                       }
                    }
                }
                task.resume()
            }
        }
    }
    
    func setupCart() {
        for product in products {
            if AppConfig.cart.count < products.count {
                var item = product
                item.quantity = 0
                AppConfig.cart.append(item)
            }
        }
    }
    
    /**
     Add or remove items from the cart.
     */
    public func changeQuantity(product: ProductModel) {
        if let index = AppConfig.cart.firstIndex(where: { $0.productName == product.productName }) {
            AppConfig.cart[index].quantity = product.quantity
        }
    }
}
