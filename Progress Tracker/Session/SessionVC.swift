//
//  SessionVC.swift
//  Progress Tracker
//
//  Created by Andrei on 2/19/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UserNotifications

class SessionVC: UIViewController {
    
    // MARK: -  properties

    let sessionVM = SessionVM()
    let db = DisposeBag()
    
    // MARK: - UI elements
    let backgroundImage: BackgroundImage = {
        let bgi = BackgroundImage(frame: UIScreen.main.bounds)
        return bgi
    }()
    
    let displayTimerView = DisplayTimerView()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = infoLabelText01
        label.textAlignment = .center
        label.font = infoLabelFont
        label.textColor = darkTextColor
        label.numberOfLines = 0
        return label
    }()
    
    let startButton: TimerButton = {
        let button = TimerButton()
        button.backgroundColor = startButtonColor
        button.setImage(#imageLiteral(resourceName: "start"), for: .normal)
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        return button
    }()
    
    let pauseButton: TimerButton = {
        let button = TimerButton()
        button.backgroundColor = pauseButtonColor
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let stopButton: TimerButton = {
        let button = TimerButton()
        button.backgroundColor = inactiveSessionButtonColor
        button.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let quitButton: TimerButton = {
        let button = TimerButton()
        button.backgroundColor = quitButtonColor
        button.setImage(#imageLiteral(resourceName: "quit"), for: .normal)
        button.addTarget(self, action: #selector(quit), for: .touchUpInside)
        return button
    }()
    
    let saveButton: TimerButton = {
        let button = TimerButton()
        button.backgroundColor = inactiveSessionButtonColor
        button.setImage(#imageLiteral(resourceName: "save"), for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        sessionVM.bindTo(displayTimeLabel: displayTimerView.timerLabel.rx.text)
        sessionVM.setupNotificationCenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            self.sessionVM.newSessionAlert(vc: self)
    }
    
    override func viewDidLayoutSubviews() {
        [startButton, pauseButton, stopButton, quitButton, saveButton].forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = sessionBackgroundColor
        [backgroundImage, displayTimerView, stopButton, pauseButton, startButton, infoLabel, saveButton, quitButton].forEach {view.addSubview($0)}
        
        //SIZE
        backgroundImage.anchorSizeRelative(to: view)
        displayTimerView.anchorSizeRelative(to: view, widthMultipler: 0.9, heightMultipler: 0.15)
        infoLabel.anchorSizeRelative(to: view, widthMultipler: 0.9, heightMultipler: 0.15)
        [startButton, pauseButton, stopButton, saveButton, quitButton].forEach {
            $0.anchorStaticSize(size: CGSize.init(width: 125, height: 125))
        }
        
        //POSITION
        backgroundImage.anchorCenterPosition(to: view)
        displayTimerView.anchor(centerX: view.centerXAnchor, centerY: nil, top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        
        [startButton, pauseButton].forEach { $0.anchor(centerX: nil, centerY: nil, top: displayTimerView.bottomAnchor, leading: displayTimerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0))}
        stopButton.anchor(centerX: nil, centerY: nil, top: displayTimerView.bottomAnchor, leading: nil, bottom: nil, trailing: displayTimerView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        
        infoLabel.anchor(centerX: view.centerXAnchor, centerY: nil, top: startButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        
        quitButton.anchor(centerX: nil, centerY: nil, top: infoLabel.bottomAnchor, leading: displayTimerView.leadingAnchor, bottom: nil, trailing: nil)
        saveButton.anchor(centerX: nil, centerY: nil, top: infoLabel.bottomAnchor, leading: nil, bottom: nil, trailing: displayTimerView.trailingAnchor)
    }
    

    
    @objc fileprivate func start() {
        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isEnabled = true
        stopButton.backgroundColor = stopButtonColor
        infoLabel.text = infoLabelText02
        sessionVM.startTimer()
    }
    
    @objc fileprivate func pause() {
        pauseButton.isHidden = true
        startButton.isHidden = false
        infoLabel.text = infoLabelText03
        sessionVM.stopOrPauseTimer()
    }
    
    @objc fileprivate func stop() {
        infoLabel.text = infoLabelText04
        [startButton, pauseButton, stopButton].forEach { $0.isHidden = true }
        saveButton.backgroundColor = saveButtonColor
        saveButton.isEnabled = true
        sessionVM.stopOrPauseTimer()
    }
    
    @objc fileprivate func quit() {
        sessionVM.stopOrPauseTimer()
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func save() {
        sessionVM.save()
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        UNService.shared.removeNotifications()
    }
    
}
