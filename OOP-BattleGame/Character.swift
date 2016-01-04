//
//  Character.swift
//  OOP-BattleGame
//
//  Created by Joshua Ide on 4/01/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int
    private var _attackPower: Int
    private var _name: String
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    init(startingHP: Int, attackPower: Int, name: String) {
        self._hp = startingHP
        self._attackPower = attackPower
        self._name = name
    }
    
    func isAlive() -> Bool {
        if hp <= 0 {
            return false
        } else {
            return true
        }
    }
    
    func attemptAttack(attackPower: Int) {
        self._hp -= attackPower
    }
    
    func reset(hp: Int) {
        self._hp = hp
    }
    
}