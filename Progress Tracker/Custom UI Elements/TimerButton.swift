//
//  TestButton.swift
//  Progress Tracker
//
//  Created by Andrei on 3/18/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit

class TimerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func bindUI() {
        self.layer.borderWidth = 5
        self.layer.borderColor = borderColor.cgColor
    }
    
    
    
}
