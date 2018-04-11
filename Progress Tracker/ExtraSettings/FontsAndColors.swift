//
//  FontsAndColors.swift
//  Progress Tracker
//
//  Created by Andrei on 3/19/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit
//MARK: - Fonts
//taskCell (each cell in the taskListVC)
let cellTaskNameFont = UIFont(name: "Avenir-Heavy", size: 25)
let cellTaskExtraInfoFont = UIFont(name: "Avenir", size: 15)
let placeHolderFont = UIFont(name: "Avenir", size: 18)

//taskVC
let taskNameFont = UIFont(name: "Avenir-Heavy", size: 30)
let sessionsCountAndTotalTimeFont = UIFont(name: "Avenir", size: 15)

//sessionVC
let buttonFont = UIFont(name: "Avenir", size: 23)
let infoLabelFont = UIFont(name: "Avenir", size: 23)
let timerFont = UIFont(name: "Avenir", size: 65)
let tagLabelFont = UIFont(name: "Avenir", size: 15)

//buttons need attributed strings to set the corresponding fonts (TODO)
let allButtonsFont = UIFont(name: "Avenir", size: 18)

//MARK: - Colors
//General
let blueButtonColor = #colorLiteral(red: 0.1398013234, green: 0.396620363, blue: 0.5617522597, alpha: 1)
let redButtonColor = #colorLiteral(red: 0.936173141, green: 0.3479156792, blue: 0.1886618435, alpha: 1)
let majorBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let inactiveSessionButtonColor = UIColor.clear
let darkTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

//TimerButton
//alpha controls the border transparency
let borderColor = UIColor(white: 1, alpha: 0.5)

//TaskCell
let taskCellContainerColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
let nameLabelTextColor = #colorLiteral(red: 0.9071571598, green: 0.9588734095, blue: 1, alpha: 1)
let sessionsCountAndProgressTimeTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

//NewTask
let taskTFBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
let taskTFPlaceholderTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//the clear and addnewtask buttons use general button colors (at the top of the file)

//TaskListVC
let tableViewBackgroundColor = UIColor.clear
let cellBackgroundOnSelectionColor = UIColor.clear

//TaskVC
//the new session and done buttons use general button colors above

//SessionVC
let sessionBackgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
let startButtonColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
let pauseButtonColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
let stopButtonColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
let quitButtonColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
let saveButtonColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

