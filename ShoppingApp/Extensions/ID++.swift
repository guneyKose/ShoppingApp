//
//  ID++.swift
//  ShoppingApp
//
//  Created by Güney Köse on 15.04.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var id: String {
        return String(describing: self)
    }
}

extension UIViewController {
    static var id: String {
        return String(describing: self)
    }
}
