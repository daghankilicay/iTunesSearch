//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 19.01.2021.
//

import UIKit
import SDWebImage

class SearchDetailViewController: BaseViewController {

    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var buttonBuy: UIButton!
    @IBOutlet weak var textView: UITextView!
    var searchDetailData : Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    private func setUI(){
        if searchDetailData != nil {
            self.imageHeader.sd_setImage(with: URL(string: searchDetailData?.artworkUrl100 ?? "") , completed: { (img, error, SDImageCacheType, URL) in
                
            });
            self.collectionName.text = searchDetailData?.trackName
            self.releaseDate.text = searchDetailData?.releaseDate?.formatSearchDate()
            self.buttonBuy.layer.cornerRadius = UIScreen.main.bounds.width * 0.064
            self.buttonBuy.layer.masksToBounds = true
            self.buttonBuy.setTitle("BUY $\(searchDetailData?.collectionPrice ?? 0)", for: .normal)
            self.textView.text = searchDetailData?.description ?? ""
        } else {
            self.showAlertMessageToBack(message: "Something went wrong")
        }
    }
    
    private func closeDetail(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertMessageToBack(message:String) {
        let alertController = UIAlertController(title: "iTunesSearch", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.closeDetail()
        }))
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func clickedBuy(_ sender: Any) {
        self.showAlertMessage(message: "You bought \(searchDetailData?.trackName ?? "") for $\(searchDetailData?.collectionPrice ?? 0)")
        self.buttonBuy.backgroundColor = UIColor.gray
        self.buttonBuy.isEnabled = false
    }
    
}
