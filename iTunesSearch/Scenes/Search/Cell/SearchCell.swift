//
//  SearchCell.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 20.01.2021.
//

import UIKit
import SDWebImage

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.collectionPrice.layer.cornerRadius = self.collectionPrice.frame.width * 0.064
        self.collectionPrice.layer.masksToBounds = true
    }
    
    func setUI(searchResult : Content?){
        self.image.sd_setImage(with: URL(string: searchResult?.artworkUrl100 ?? "") , completed: { (img, error, SDImageCacheType, URL) in
            
        });
        self.collectionName.text = searchResult?.trackName ?? ""
        self.collectionPrice.text = "$\(searchResult?.collectionPrice ?? 0)"
        self.releaseDate.text = searchResult?.releaseDate?.formatSearchDate()
    }
    
    

}
