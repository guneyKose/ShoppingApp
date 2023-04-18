//
//  MainFooterView.swift
//  ShoppingApp
//
//  Created by Güney Köse on 16.04.2023.
//

import UIKit

class MainFooterView: UICollectionReusableView {

    @IBOutlet weak var totalAmountButton: UIButton!
    
    weak var delegate: ProductFooterProtocol?
    
    func setFooter() {
        let formattedTotal = String(format: "%.2f", AppConfig.totalPrice)
        let buttonText = "Total Amount \(formattedTotal)₺"
        self.totalAmountButton.setTitle(buttonText, for: .normal)
    }
    
    @IBAction func goToCart(_ sender: UIButton) {
        self.delegate?.goToCart()
    }
}
