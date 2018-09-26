//
//  SettingsSingleton.swift
//  Set
//
//  Created by Tommy Howell on 9/25/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import Foundation
import UIKit

class SettingsSingleton {
    private init(){}
    static public var settingsSingleton = SettingsSingleton()
    
    var colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.04873471707, green: 0.1469966173, blue: 0.2019610107, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
    
    func replaceColors(with newColors: [UIColor]){
        if newColors.count == 3 {
            colors = newColors
        }
    }
    
    func getColors() -> [UIColor] {
        return colors
    }
    
}
