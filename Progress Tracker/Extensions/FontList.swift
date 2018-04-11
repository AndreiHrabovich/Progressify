//
//  Font List.swift
//  RxSwiftTestDevslopes
//
//  Created by Andrei on 1/25/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit

// quickly listing all the available fonts and choosing the exact name of the one you need to use programmatically
// call in viewDidLoad
func listFonts() {
    for family in UIFont.familyNames {
        for font in UIFont.fontNames(forFamilyName: family) {
            print(font)
        }
    }
}



