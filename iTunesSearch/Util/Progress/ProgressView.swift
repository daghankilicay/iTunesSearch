//
//  ProgressView.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 21.01.2021.
//

import UIKit

class ProgressView: UIView {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    static func showProgress() -> ProgressView {
        
        let design = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?[0] as! ProgressView
        design.frame = screen()
        let window = UIApplication.shared.windows.first
        window?.addSubview(design)
        window?.bringSubviewToFront(design)
        design.indicator.startAnimating()
        
         return design
    }

}
