//
//  ProductDetailController.swift
//  ShoppingApp
//
//  Created by Güney Köse on 16.04.2023.
//

import UIKit

class ProductDetailController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var updateCartButton: UIButton!
    
    var activity: UIActivityIndicatorView!
    
    let viewModel = ProductDetailVM()
    
    weak var delegate: ProductDetailProtocol?
    
    //MARK: - Setup
    public func setup(product: ProductModel) {
        self.viewModel.product = product
        self.viewModel.quantity = product.quantity ?? 0
        self.view.backgroundColor = .white
        self.navigationItem.title = self.viewModel.title
        self.detailLabel.text = product.productDescription
        self.setupLabel()
        self.setupTitle()
        self.setupButton()
        if let imageURLString = product.productImage {
            self.setupActivityIndicator(create: true)
            self.productImage.loadImage(from: imageURLString) { [weak self] in
                guard let self = self else { return }
                self.setupActivityIndicator(create: false)
            }
        }
    }
    
    private func setupTitle() {
        if  let product = self.viewModel.product,
            let price = product.productPrice,
            let name = product.productName {
            let priceString = price.getPriceString()
            let titleText = name + " " + priceString
            let title = NSMutableAttributedString(string: titleText)
            let range = (titleText as NSString).range(of: priceString)
            
            title.addAttribute(.foregroundColor,
                                   value: UIColor.purple,
                                   range: range)
            
            self.titleLabel.attributedText = title
        }
    }
    
    private func setupLabel() {
        quantityLabel.text = "\(viewModel.quantity)"
    }
    
    private func setupButton() {
        let buttonTitle = viewModel.buttonTitle + " " + viewModel.totalPrice.getPriceString()
        self.updateCartButton.setTitle(buttonTitle,
                                       for: .normal)
    }
    
    private func setupActivityIndicator(create: Bool) {
        if create {
            self.activity = UIActivityIndicatorView(frame: productImage.frame)
            self.activity.color = .purple
            self.activity.style = .medium
            self.activity.startAnimating()
            self.productImage.addSubview(activity)
        } else {
            self.activity.stopAnimating()
            self.activity.removeFromSuperview()
        }
    }
    
    //MARK: - Button Actions
    @IBAction func increase(_ sender: UIButton) {
        viewModel.quantity += 1
        self.viewModel.changeQuantity(isIncrease: true)
        self.setupLabel()
        self.setupButton()
    }
    
    @IBAction func decrease(_ sender: UIButton) {
        if viewModel.quantity > 0 {
            self.viewModel.quantity -= 1
            self.viewModel.changeQuantity(isIncrease: false)
            self.setupLabel()
            self.setupButton()
        }
    }
    
    @IBAction func updateCart(_ sender: UIButton) {
        if let product = viewModel.product {
            var item = product
            item.quantity = self.viewModel.quantity
            self.delegate?.updateCart(product: item)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
