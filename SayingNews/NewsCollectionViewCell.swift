//
//  NewsCollectionViewCell.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/21.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UIButton! {
        didSet {
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    var collectionButtondelegate: SayingNewsCollectionButtonDelegate!
    var newsKey: String!
    
    @IBAction func button(_ sender: UIButton) {
        if let selectedKey = sender.titleLabel?.text {
//            print("Selected: \(selectedKey)")
            collectionButtondelegate?.buttonTapped(at: selectedKey)
        }
    }

}

protocol SayingNewsCollectionButtonDelegate{
    func buttonTapped(at newsKey: String)
}
