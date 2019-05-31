//
//  Extensions.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 30/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            return nil
        }
    }
}
