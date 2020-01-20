//
//  View+Render.swift
//  Instagrid
//
//  Created by SAKA Ridvan on 20/01/2020.
//  Copyright © 2020 SAKA Ridvan. All rights reserved.
//

import UIKit

// MARK: UIView

extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
