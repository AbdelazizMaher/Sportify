//
//  UserDefault.swift
//  Sportify
//
//  Created by Ali_Kotb on 29/05/2025.
//

import Foundation

func setIsFirstTime (isFirst : Bool){
    UserDefaults.standard.setValue(isFirst, forKeyPath: "isFirst")
}

func getIsFirstTime () -> Bool{
    return UserDefaults.standard.bool(forKey: "IsFirst")
}
