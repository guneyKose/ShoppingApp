//
//  CheckoutFooter.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import UIKit

class CheckoutFooter: UITableViewHeaderFooterView {

    @IBOutlet weak var checkoutButton: UIButton!
    
    weak var delegate: CheckoutProtocol?
    
    func setup() {
        let buttonText = "Checkout: " + AppConfig.totalPrice.getPriceString()
        self.checkoutButton.setTitle(buttonText, for: .normal)
    }

    @IBAction func checkout(_ sender: UIButton) {
        self.delegate?.checkout()
    }
}
