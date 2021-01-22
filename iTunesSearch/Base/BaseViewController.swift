//
//  BaseViewController.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 19.01.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    var progress : ProgressView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // StatusBar Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showAlertMessage(message:String) {

        let alertController = UIAlertController(title: "iTunesSearch", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showProgress(){
        self.progress = ProgressView.showProgress()
    }
    
    func hideProgress() {
        self.progress?.removeFromSuperview()
    }

}
