//
//  ViewController.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/19.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let synthesizer = AVSpeechSynthesizer()
    var isSpeakingBarViewActive: Bool?
    var speakingCell: NewsTableViewCell?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJsonData(from: DataSource.techcrunch!)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, * ) {
            self.navigationItem.searchController = searchController
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)


        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height:1)
        }
        synthesizer.delegate = self
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.searchController.searchBar.resignFirstResponder()
    }
    
    var articles = [Article]()
    
    func fetchJsonData(from url: URL) {
        URLSession.shared.dataTask(with: url){ data, urlResponse, error in
            guard let data = data, urlResponse != nil, error == nil else {
                print("fetching data problem...")
                return }
            do {
                let articlesJson = try JSONDecoder().decode(Articles.self, from: data)
                self.articles = articlesJson.articles!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("wrong after fetching json:\(error)")
            }
            
        }.resume()
    }
    
    var searchFilter = "" {
        didSet {
            print("this is the searchFilter")
            filter()
        }
    }
    
    var filteredResult: [Article] = []
    
    func filter() {
        print("this is the filter")
        filteredResult = articles.filter { article in
            return article.title.localizedLowercase.contains(searchFilter.localizedLowercase) || article.description.localizedLowercase.contains(searchFilter.localizedLowercase)
            
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("this is the updateSearchResults...")
        guard let searchText = searchController.searchBar.text else {
            return
        }
        self.searchFilter = searchText
        self.tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(true, animated: true)
//        searchBar.becomeFirstResponder()
//    }
//    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
//
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.setShowsCancelButton(false, animated: true)
//        return true
//    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SayingNewsCollectionButtonDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataSource.newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? NewsCollectionViewCell
        let title = NSAttributedString(string: DataSource.newsArray[indexPath.item])
        cell?.label.setAttributedTitle(title, for: .normal)
        cell?.collectionButtondelegate = self
        return cell!
    }
    
    func buttonTapped(at newsKey: String) {
        switch newsKey {
            case "ABC" : fetchJsonData(from: DataSource.ABCNews!)
            case "Financial Times" : fetchJsonData(from: DataSource.financialTimes!)
            case "Fox" : fetchJsonData(from: DataSource.foxNews!)
            case "TechCrunch" : fetchJsonData(from: DataSource.techcrunch!)
            case "NBC" : fetchJsonData(from: DataSource.NBCNews!)
            default:
                fetchJsonData(from: DataSource.googleNewsTop!)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, SayingNewsButtonDelegate, AVSpeechSynthesizerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchFilter.isEmpty ? articles.count : filteredResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell
        let article = searchFilter.isEmpty ? articles[indexPath.row] : filteredResult[indexPath.row]
        if let img = article.urlToImage {
            cell?.imgView.fetchImg(from: img)
        } 
        cell?.titleLabel.text = article.title
        cell?.subTitleLabel.text = article.description
        cell?.delegate = self
        cell?.indexPath = indexPath
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebviewViewController
        webVC.url = self.articles[indexPath.row].url
        self.present(webVC, animated: true, completion: nil)
    }
    
    private func didSpeakingStop() {
        synthesizer.stopSpeaking(at: .immediate)
        speakingCell?.controlLabel.setTitle("▶️", for: .normal)
        speakingCell = nil
    }
    
    func controlButtonTapped(at index: IndexPath) {
        if speakingCell != nil, speakingCell?.indexPath != index  {
            didSpeakingStop()
            speakingCell = tableView.cellForRow(at: index) as? NewsTableViewCell
            speakingCell?.controlLabel.setTitle("⏸", for: .normal)
            let utterance = AVSpeechUtterance(string: articles[index.row].description)
            synthesizer.speak(utterance)
        } else if speakingCell != nil, speakingCell?.indexPath == index {
            if speakingCell?.controlLabel.titleLabel?.text == "⏸" {
                didSpeakingStop()
            }
        } else {
            speakingCell = tableView.cellForRow(at: index) as? NewsTableViewCell
            speakingCell?.controlLabel.setTitle("⏸", for: .normal)
            let utterance = AVSpeechUtterance(string: articles[index.row].description)
            synthesizer.speak(utterance)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        didSpeakingStop()
    }
}

extension UIImageView {
    func fetchImg(from url: String) {
        if let imgURL = URL(string: url) {
            DispatchQueue.global().async {[weak self] in
                if let data = try? Data(contentsOf: imgURL){
                    if let img = UIImage(data: data){
                        DispatchQueue.main.async {
                            self?.image = img
                        }
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: self)
        return date!
    }
}


