//
//  DisplayTìmerView.swift
//  Progress Tracker
//
//  Created by Andrei on 3/19/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit

class DisplayTimerView: UIView {
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.textColor = darkTextColor
        label.font = timerFont
        return label
    }()
    
    fileprivate let tagsLabel: UILabel = {
        let label = UILabel()
        label.text = tagsLabelText
        label.textColor = darkTextColor
        label.textAlignment = .center
        label.font = tagLabelFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func bindUI() {

        [timerLabel, tagsLabel].forEach {self.addSubview($0)}
        timerLabel.anchorCenterPosition(to: self)
        timerLabel.anchorSizeRelative(to: self, widthMultipler: 1, heightMultipler: 0.7)
        tagsLabel.anchor(centerX: nil, centerY: nil, top: timerLabel.bottomAnchor, leading: timerLabel.leadingAnchor, bottom: nil, trailing: timerLabel.trailingAnchor)
        tagsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
}
