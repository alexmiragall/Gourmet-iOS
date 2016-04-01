//
//  JSONAble.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 1/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation

protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}