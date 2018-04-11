//
//  TaskListVC.swift
//  Progress Tracker
//
//  Created by Andrei on 2/25/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Realm
import RealmSwift
import UserNotifications

class TaskListVC: UIViewController {
    
    // MARK: -  properties
    
    let taskListVM = TaskListVM()
    let db = DisposeBag()
    
    // MARK: - UI elements
    
    let newTask: NewTask = {
        let nt = NewTask()
        return nt
    }()
    
    let backgroundImage: BackgroundImage = {
        let bgi = BackgroundImage(frame: UIScreen.main.bounds)
        return bgi
    }()
    
    let tv: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = tableViewBackgroundColor
        tv.separatorStyle = .none
        return tv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        return sv
    }()
    
    // MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        tv.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
        bindUI()
        bindRxTableView()
        bindTaskButtons()
        taskListVM.populateTableView()
    }
    
    fileprivate func bindRxTableView() {
        
        taskListVM.tasks.asDriver().asDriver(onErrorJustReturn:[]).drive(tv.rx.items(cellIdentifier: "taskCell", cellType: TaskCell.self)) { (_, task, cell) in
            cell.name = task.name
            cell.sessionsCount = task.sessions.count
            cell.progressTime = task.progressTime

            let cellBackgroundOnSelection = UIView()
            cellBackgroundOnSelection.backgroundColor = cellBackgroundOnSelectionColor
            cell.selectedBackgroundView = cellBackgroundOnSelection
            
            cell.layoutSubviews()
            }.disposed(by: db)
        
        tv.rx.modelSelected(Task.self)
            .subscribe(onNext: { [unowned self] in
                let tVC = self.taskListVM.goToSelectedTask(selectedTask: $0)
                self.present(tVC, animated: true, completion: nil)
            }).disposed(by: db)
        
        tv.rx.itemDeleted
            .subscribe(onNext: { [unowned self] in
                let realmItem = self.taskListVM.tasks.value[$0.item]
                try! self.taskListVM.realm.write {
                    self.taskListVM.realm.delete(realmItem)
                }
                self.taskListVM.tasks.value.remove(at: $0.item)
            }).disposed(by: db)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tv.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        [newTask.taskTF, newTask.clearTaskButton, newTask.addNewTaskButton].forEach {
            $0.layer.cornerRadius = newTask.addNewTaskButton.frame.height / 2
        }
    }
    
    fileprivate func bindUI() {
        view.backgroundColor = majorBackgroundColor
        
        [backgroundImage, stackView].forEach { view.addSubview($0) }
        [newTask, tv].forEach { stackView.addArrangedSubview($0)}
        
        //SIZE
        backgroundImage.anchorSizeRelative(to: view)
        newTask.anchorSizeRelative(to: stackView, widthMultipler: 1, heightMultipler: 0.3)
        tv.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        //POSITION
        backgroundImage.anchorCenterPosition(to: view)
        stackView.anchor(centerX: nil, centerY: nil, top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    fileprivate func bindTaskButtons() {
        newTask.addNewTaskButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                guard let name = self.newTask.taskTF.text else { return }
                self.taskListVM.createNewTask(forVC: self, withName: name)
                self.tv.reloadData()
                self.newTask.taskTF.rx.text.onNext("")
                self.view.endEditing(true)
            }).disposed(by: db)
        
        newTask.clearTaskButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.newTask.taskTF.rx.text.onNext("")
                self.view.endEditing(true)
            }).disposed(by: db)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



