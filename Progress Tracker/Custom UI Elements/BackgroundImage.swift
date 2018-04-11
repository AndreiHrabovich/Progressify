//
//  BackgroundImage.swift
//  Progress Tracker
//
//  Created by Andrei on 3/19/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit

class BackgroundImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func bindUI() {
        self.image = #imageLiteral(resourceName: "timeismoney")
        self.contentMode = .scaleAspectFill
        self.alpha = 0.2
    }

}
