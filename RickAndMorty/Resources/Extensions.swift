//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
