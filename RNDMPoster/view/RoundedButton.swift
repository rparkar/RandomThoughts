//
//  RoundedButton.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-27.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = layer.frame.width / 2
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
