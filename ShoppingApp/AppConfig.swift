//
//  AppConfig.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import Foundation

enum AppConfig {
    
    static var cart: [ProductModel] = [] {
        didSet {
            guard !isResetting else { return }
            AppConfig.getTotalPrice()
            AppConfig.saveCart()
        }
    }
    
    static var totalPrice: Double = 0
    
    private static var isResetting = false
    
    private static func getTotalPrice() {
        AppConfig.totalPrice = 0
        for product in AppConfig.cart {
            AppConfig.totalPrice += Double(product.quantity ?? 0) * (product.productPrice ?? 0)
        }
    }
    
    private static func saveCart() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(AppConfig.cart)
            UserDefaults.standard.set(data, forKey: "cartData")
        } catch {
            debugPrint("Error accured.")
        }
    }
    
    public static func getCartData() {
        guard let data = UserDefaults.standard.data(forKey: "cartData")
        else { return }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode([ProductModel].self, from: data)
            AppConfig.cart = data
        } catch {
            debugPrint("Could not get data.")
        }
    }
    
    /**
     Reset cart.
     */
    public static func resetCart() {
        DispatchQueue.global(qos: .background).async {
            AppConfig.isResetting = true
            for (i, _) in AppConfig.cart.enumerated() {
                AppConfig.cart[i].quantity = 0
            }
            AppConfig.isResetting = false
            AppConfig.getTotalPrice()
            AppConfig.saveCart()
            AppConfig.totalPrice = 0
        }
    }
}
