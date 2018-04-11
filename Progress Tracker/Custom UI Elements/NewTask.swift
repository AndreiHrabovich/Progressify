//
//  NewTask.swift
//  Progress Tracker
//
//  Created by Andrei on 2/26/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewTask: UIView {
    
    let db = DisposeBag()
    
    let taskTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = taskTFBackgroundColor
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: taskTFPlaceholderTextColor, .font: placeHolderFont ?? UIFont.systemFont(ofSize: 16)]
        tf.attributedPlaceholder = NSAttributedString(string: phText, attributes: attributes)
        tf.textAlignment = .center
        return tf
    }()
    
    let addNewTaskButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = blueButtonColor
        button.isEnabled = false
        button.setTitle(addNewTaskText, for: .normal)
        return button
    }()
    
    let clearTaskButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = redButtonColor
        button.isEnabled = false
        button.setTitle(clearTaskText, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
    }
    
    fileprivate func bindUI() {
        self.backgroundColor = UIColor.clear
        self.addSubview(stackView)
        
        stackView.anchorSizeRelative(to: self)
        stackView.anchorCenterPosition(to: self)
        
        [taskTF, addNewTaskButton, clearTaskButton].forEach {
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
        }
        
        let textFieldObservable = taskTF.rx.text
            .map { $0 != "" ?  true :  false }
        textFieldObservable.bind(to: addNewTaskButton.rx.isEnabled).disposed(by: db)
        textFieldObservable.bind(to: clearTaskButton.rx.isEnabled).disposed(by: db)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
