//
//  ListeningTableViewCell.swift
//  ListeningNews
//
//  Created by duoda james on 2018/9/16.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import UIKit

class SpeakingBarView: UIView {
    
    @IBOutlet weak var timeCounter: UIView!
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        let volumeValue = Int(sender.value)
        volumeLabel.text = "\(volumeValue)"
    }
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedStepper: UIStepper!
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let speedValue = Int(sender.value)
        speedLabel.text = "\(speedValue)"
    }
    
    
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBAction func pauseButton(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
