//
//  NewsTableViewCell.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/19.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView! {
        didSet {
                if imgView.image == nil {
                    imgView.image = UIImage(named: "default.jpg")
                }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var delegate:SayingNewsButtonDelegate!
    var indexPath:IndexPath!
    @IBOutlet weak var controlLabel: UIButton!
    @IBAction func controlButton(_ sender: UIButton) {
        self.delegate?.controlButtonTapped(at: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

protocol SayingNewsButtonDelegate{
    func controlButtonTapped(at index:IndexPath)
}
