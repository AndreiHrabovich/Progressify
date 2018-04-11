//
//  TaskCell.swift
//  Progress Tracker
//
//  Created by Andrei on 2/26/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    
    var name: String?
    var sessionsCount: Int?
    var progressTime: String?
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = taskCellContainerColor
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = cellTaskNameFont
        label.textColor = nameLabelTextColor
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let sessionsCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = cellTaskExtraInfoFont
        label.textColor = sessionsCountAndProgressTimeTextColor
        return label
    }()
    
    let progressTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = cellTaskExtraInfoFont
        label.textColor = sessionsCountAndProgressTimeTextColor
        return label
    }()
    
    let bottonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindUI()
    }
    
    fileprivate func bindUI() {
        self.backgroundColor = UIColor.clear
        self.addSubview(containerView)

        [nameLabel, bottonStackView].forEach { containerView.addSubview($0)}
        [sessionsCountLabel, progressTimeLabel].forEach { bottonStackView.addArrangedSubview($0)}
        
        //SIZE and POSITION
        containerView.anchorSizeRelative(to: self, widthMultipler: 1, heightMultipler: 0.9)
        containerView.anchorCenterPosition(to: self)
        
        nameLabel.anchor(centerX: nil, centerY: nil, top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        bottonStackView.anchor(centerX: nil, centerY: nil, top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nameLabel.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let name = name else { return }
        guard let sessionsCount = sessionsCount else { return }
        guard let progressTime = progressTime else { return }
        
        nameLabel.text = name
        sessionsCountLabel.text = sessionsCountLabelText + "\(sessionsCount)" 
        progressTimeLabel.text = progressTime
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
