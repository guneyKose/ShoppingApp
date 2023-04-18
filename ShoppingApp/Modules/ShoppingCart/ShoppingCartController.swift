//
//  ShoppingCartController.swift
//  ShoppingApp
//
//  Created by Güney Köse on 17.04.2023.
//

import UIKit

class ShoppingCartController: UIViewController {
    
    var cartTableView: UITableView!
    
    let viewModel = ShoppingCartVM()
    
    public func setup() {
        self.viewModel.cart = AppConfig.cart.filter({ $0.quantity ?? 0 > 0 })
        self.view.backgroundColor = .white
        self.navigationItem.title = "Shopping Cart"
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.cartTableView = UITableView(frame: self.view.frame)
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        self.cartTableView.backgroundColor = .white
        self.cartTableView.register(self.viewModel.nib,
                                    forCellReuseIdentifier: ShoppingCartCell.id)
        self.cartTableView.register(self.viewModel.footerNib,
                                    forHeaderFooterViewReuseIdentifier: CheckoutFooter.id)
        self.view.addSubview(self.cartTableView)
    }
}

//MARK: - TableView
extension ShoppingCartController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartCell.id,
                                                       for: indexPath) as? ShoppingCartCell
        else { fatalError(ShoppingCartCell.id) }
        cell.setup(product: self.viewModel.cart[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width / 4
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: CheckoutFooter.id)
                as? CheckoutFooter else { fatalError(CheckoutFooter.id) }
        footer.setup()
        footer.delegate = self
        footer.contentView.backgroundColor = .white
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.footerHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete")
        { [weak self] (_, _, _) in
            self?.viewModel.cart[indexPath.row].quantity = 0
            self?.updateCart(product: self?.viewModel.cart[indexPath.row])
        }
        delete.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
}
