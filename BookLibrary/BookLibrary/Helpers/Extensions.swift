//
//  Extensions.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 30/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

// MARK: - For taking image from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
