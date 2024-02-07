//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Erdem Perşembe on 12.04.2022.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var productCollectionView: UICollectionView!
    
    let viewModel = ProductsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupCollectionView()
        viewModel.fetchProducts { [weak self] success in
            guard let self else { return }
            self.productCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.productCollectionView.reloadData()
    }
    
    //MARK: - Setup
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Products"
        self.navigationController?.navigationBar.tintColor = .purple
    }
    
    private func setupCollectionView() {
        self.productCollectionView = UICollectionView(frame: self.view.frame,
                                                      collectionViewLayout: self.viewModel.collectionViewLayout())
        self.productCollectionView.backgroundColor = .white
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        
        self.productCollectionView.register(viewModel.nib, forCellWithReuseIdentifier: ProductCell.id)
        self.productCollectionView.register(viewModel.footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainFooterView.id)
        self.view.addSubview(self.productCollectionView)
    }
}

//MARK: - CollectionView Delegate & DataSource
extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.id, for: indexPath) as? ProductCell else { fatalError(ProductCell.id) }
        cell.setup(product: AppConfig.cart[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 60) / 2
        return CGSize(width: width, height: width * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = viewModel.productDetailStoryboard.instantiateViewController(withIdentifier: ProductDetailController.id) as? ProductDetailController {
            let product = AppConfig.cart[indexPath.row]
            vc.setup(product: product)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainFooterView.id, for: indexPath) as? MainFooterView else { fatalError(MainFooterView.id) }
        footer.delegate = self
        footer.setFooter() //Setting footer title.
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerHeight: Double = self.viewModel.products.isEmpty ? Double.leastNonzeroMagnitude : 70
        return CGSize(width: self.view.frame.width, height: footerHeight)
    }
}

