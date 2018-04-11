//
//  TestVC.swift
//  Progress Tracker
//
//  Created by Andrei on 2/19/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UserNotifications

class TaskVC: UIViewController {
    
    // MARK: -  properties
    
    let taskVM = TaskVM()
    let db = DisposeBag()
    
    // MARK: - UI elements
    
    let backgroundImage: BackgroundImage = {
        let bgi = BackgroundImage(frame: UIScreen.main.bounds)
        return bgi
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = taskNameFont
        label.numberOfLines = 5
        return label
    }()
    
    let sessionsCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = sessionsCountAndTotalTimeFont
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = sessionsCountAndTotalTimeFont
        return label
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = blueButtonColor
        button.setTitle(goButtonText, for: .normal)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = redButtonColor
        button.setTitle(doneButtonText, for: .normal)
        return button
    }()
    
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        setupUI()
        bindButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = taskVM.task.name
        sessionsCountLabel.text = sessionsCountLabelText + "\(taskVM.task.sessions.count)"
        totalTimeLabel.text = taskVM.task.progressTime
    }
    
    override func viewDidLayoutSubviews() {
        [goButton, doneButton].forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = majorBackgroundColor
        [nameLabel, sessionsCountLabel, totalTimeLabel].forEach { $0.textColor = darkTextColor }
        [backgroundImage, nameLabel, sessionsCountLabel, totalTimeLabel, goButton, doneButton].forEach { view.addSubview($0)}

        //SIZE
        backgroundImage.anchorSizeRelative(to: view)
        [goButton, doneButton].forEach { $0.anchorSizeRelative(to: view, widthMultipler: 0.9, heightMultipler: 0.1) }
        
        //POSITION
        backgroundImage.anchorCenterPosition(to: view)
        nameLabel.anchor(centerX: view.centerXAnchor, centerY: nil, top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 10, bottom: 0, right: 10))
        
        sessionsCountLabel.anchor(centerX: nil, centerY: nil, top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        totalTimeLabel.anchor(centerX: nil, centerY: nil, top: sessionsCountLabel.bottomAnchor, leading: sessionsCountLabel.leadingAnchor, bottom: nil, trailing: sessionsCountLabel.trailingAnchor)
        [sessionsCountLabel, totalTimeLabel].forEach { $0.heightAnchor.constraint(equalToConstant: 30).isActive = true }
        
        goButton.anchor(centerX: view.centerXAnchor, centerY: nil, top: nil, leading: nil, bottom: doneButton.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        doneButton.anchor(centerX: view.centerXAnchor, centerY: nil, top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 50, right: 0))
    }
    
    
    fileprivate func bindButtons() {
 
        goButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                let sVC = self.taskVM.createNewSessionVC()
                self.present(sVC, animated: true, completion: nil)
            }).disposed(by: db)
        
        doneButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: db)
    }
    
}
