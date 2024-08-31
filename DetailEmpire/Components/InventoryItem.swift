//
//  InventoryItem.swift
//  DetailEmpire
//
//  Created by John Crawford on 8/29/24.
//

import Foundation

struct InventoryItem:Identifiable{
//    @Published var price = 0
//    @Published var name = ""
//    @Published var desc = ""
//    @Published var levelUnlock = 0
//    @Published var usesPerVehicle = -1
//    
//    @ObservedObject var gameState = GameState()
    
    var id = UUID()
    var price:Double
    var name:String
    var desc:String
    var levelUnlocked:Int
    var usesPerVehicle:Int
    var usesRemaining:Int
    var icon:String
    var purchased:Bool
    var startingItem:Bool
    var itemMultiplier:Double?
    
    func buy(){
//        gameState.money -= self.price
    }

}
