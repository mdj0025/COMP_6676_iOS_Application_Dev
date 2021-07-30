//
//  DataManager.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/25/21.
//

import Foundation

protocol DataManager
{
    func load(file name: String) -> [[String:AnyObject]]
}

extension DataManager
{
    func load(file name: String) -> [[String:AnyObject]]
    {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"), let items = NSArray(contentsOfFile: path)
        else
        {
            return[[:]]
        }
        return items as! [[String:AnyObject]]
    }
}

