//
//  UIImageView++.swift
//  ShoppingApp
//
//  Created by Güney Köse on 15.04.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String, _ completion: @escaping () -> Void) {
        guard let url = URL(string: urlString + "?raw=true") else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion()
                    }
                }
            }
        }
    }
}
