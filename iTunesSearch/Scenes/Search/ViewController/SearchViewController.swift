//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 19.01.2021.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentContol: UISegmentedControl!
    var searchActive : Bool = false
    
    var baseResult : [Content]?
    private var searchViewModel : SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextColors()
        self.searchViewModel =  SearchViewModel()
        self.collectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.baseResult != nil && (self.baseResult?.count)! > 0 {
            return (self.baseResult?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let result = self.baseResult?[indexPath.row]
        cell.setUI(searchResult: result)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: segmentView.frame.height, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 10, height: 200 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        let searchDetailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchDetailViewController") as! SearchDetailViewController
        searchDetailVC.searchDetailData = self.baseResult?[indexPath.row]
        self.navigationController?.pushViewController(searchDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (self.baseResult?.count)! - 1  {
            self.loadMoreChapter()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    private var offset = 0
    private func loadMoreChapter() {
        self.offset += 20
        self.callToViewModelForUIUpdate(termValue: searchBar.text, entityValue: self.segmentText, offsetValue: self.offset, limit: 20)
    }
    
    func callToViewModelForUIUpdate(termValue: String?, entityValue: String?, offsetValue: Int, limit: Int){
        self.searchViewModel.callFuncToGetEmpData(termValue: termValue, entityValue: entityValue, offsetValue: offsetValue, limit: limit)
        self.searchViewModel.bindCountryViewModelToController = { [self] result -> Void in
            if result.results.count >= 0{
                self.baseResult?.append(contentsOf: result.results)
                self.updateDataSource()
            }
        }
        self.searchViewModel.bindErrorToController = { error -> Void in
            self.showAlertMessage(message: error!.localizedDescription)
            self.hideProgress()
        }
    }
    
    func updateDataSource(){
        self.collectionView.reloadData()
        self.hideProgress()
    }
    
    var segmentText : String = ResultType.movie.rawValue
    @IBAction func segmentControl(_ sender: Any) {
        switch segmentContol.selectedSegmentIndex
            {
            case 0:
                self.segmentText = ResultType.movie.rawValue
            case 1:
                self.segmentText = ResultType.musicVideo.rawValue
            case 2:
                self.segmentText = ResultType.software.rawValue
            case 3:
                self.segmentText = ResultType.ebook.rawValue
            default:
                break
            }
        self.searchBar.endEditing(true)
        self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.updateCollectionView(termValue: searchBar.text, entityValue: self.segmentText, offsetValue: 0, limit: 20)
    }
    
    // SearchBar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2{
            hideProgress()
            self.updateCollectionView(termValue: searchBar.text, entityValue: self.segmentText, offsetValue: 0, limit: 20)
        }
    }
    
    private func updateCollectionView(termValue: String?, entityValue: String?, offsetValue: Int, limit: Int){
        if ((searchBar.text?.isEmpty) != nil){
            self.showProgress()
            self.baseResult = []
            self.callToViewModelForUIUpdate(termValue:termValue , entityValue:entityValue , offsetValue: offsetValue, limit: limit)
        }
    }
    
    func setTextColors(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.segmentContol.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentContol.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
    }
}

