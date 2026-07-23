//
//  FeedModel.swift
//  Navigation
//
//  Created by Mysty Mystylal on 22.07.2026.
//

import Foundation

class FeedModel{
    private let secreWord: String = "vadim"
    
    func check(word: String, end: (Bool) -> Void){
        end(word == secreWord)
    }
}
