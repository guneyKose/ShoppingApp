//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Güney Köse on 15.04.2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var activity: UIActivityIndicatorView!
    var priceLabel: UILabel!
    
    var product: ProductModel?
        
    weak var delegate: ProductCellProtocol?
    
    override func prepareForReuse() {
        self.productTitle.text = ""
        self.priceLabel.text = ""
        self.productImage.image = nil
        self.activity.removeFromSuperview()
    }
    
    func setup(product: ProductModel) {
        self.setupUI()
        self.product = product
        self.productTitle.text = product.productName

        if let productPrice = product.productPrice {
            priceLabel.text = "\(productPrice)₺"
            priceLabel.textColor = .purple
            priceLabel.font = UIFont.systemFont(ofSize: 16)
        }
        
        if let imageURLString = product.productImage {
            self.productImage.loadImage(from: imageURLString) { [weak self] in
                guard let self = self else { return }
                self.activity.stopAnimating()
                self.activity.isHidden = true
            }
        }
        
        if let quantity = product.quantity {
            self.quantityLabel.text = "\(quantity)"
        }
    }
    
    private func setupUI() {
        self.activity = UIActivityIndicatorView(frame: self.bounds)
        self.activity.startAnimating()
        self.activity.style = .medium
        self.activity.color = .purple
        self.activity.removeFromSuperview()
        self.addSubview(activity)
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.productTitle.textColor = .black
        self.layer.borderColor = UIColor.purple.cgColor
        self.layer.borderWidth = 1
        
        self.priceLabel = UILabel(frame: CGRect(x: 12,
                                                y: 0,
                                                width: self.bounds.width,
                                                height: 30))
        
        self.addSubview(priceLabel)
    }
    
    private func changeQuantity(isIncrease: Bool) {
        guard let product = self.product else { return }
        let index = AppConfig.cart.firstIndex(where: { $0.productName == product.productName }) ?? 0
        if AppConfig.cart[index].quantity != nil {
            if isIncrease {
                AppConfig.cart[index].quantity! += 1
            } else {
                if AppConfig.cart[index].quantity ?? 0 > 0 {
                    AppConfig.cart[index].quantity! -= 1
                }
            }
            self.delegate?.productStatusChanged()
            self.quantityLabel.text = "\(AppConfig.cart[index].quantity ?? 0)"
        }
    }
    
    @IBAction func increase(_ sender: UIButton) {
        self.changeQuantity(isIncrease: true)
    }
    
    @IBAction func decrease(_ sender: UIButton) {
        self.changeQuantity(isIncrease: false)
    }
}
