//
//  ShoppingCartCell.swift
//  ShoppingApp
//
//  Created by Güney Köse on 18.04.2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    var activity: UIActivityIndicatorView!
    
    lazy var quantity: Int = 0
    var product: ProductModel?
    
    weak var delegate: ShoppingCellProtocol?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.image = nil
        productName.text = ""
        productQuantityLabel.text = "0"
    }
    
    //MARK: - Setup
    func setup(product: ProductModel?) {
        if let name = product?.productName,
           let quantity = product?.quantity,
           let image = product?.productImage {
            self.product = product
            self.quantity = quantity
            self.productName.text = name
            self.productQuantityLabel.text = "\(self.quantity)"
            self.setupActivityIndicator(create: true)
            self.productImage.loadImage(from: image) {
                self.setupActivityIndicator(create: false)
            }
        }
    }
    
    func setupActivityIndicator(create: Bool) {
        if create {
            self.activity = UIActivityIndicatorView(frame: self.productImage.frame)
            self.activity.color = .purple
            self.activity.startAnimating()
            if !self.contains(activity) {
                self.addSubview(activity)
            }
        } else {
            self.activity.stopAnimating()
            self.activity.isHidden = true
        }
    }
    
    //MARK: - Button Actions
    @IBAction func increase(_ sender: UIButton) {
        self.quantity += 1
        self.product?.quantity = self.quantity
        self.delegate?.updateCart(product: self.product)
    }
    
    @IBAction func decrease(_ sender: UIButton) {
        if quantity > 0 {
            self.quantity -= 1
        } else {
            self.quantity = 0
        }
        self.product?.quantity = self.quantity
        self.delegate?.updateCart(product: self.product)
    }
}
