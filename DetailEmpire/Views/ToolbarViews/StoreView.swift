//
//  FinanceView.swift
//  DetailEmpire
//
//  Created by John Crawford on 8/29/24.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject var storeItems = StoreItems()
    @ObservedObject var gameState = GameState()
    
//    struct BlueButtonStyle: ButtonStyle {
//        func makeBody(configuration: Self.Configuration) -> some View {
//            configuration.label
//                .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
//                .background(configuration.isPressed ? Color.white : Color.blue)
//                .cornerRadius(4)
//                .padding()
//        }
//    }
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
//        Text("Store")
//            .font(.headline)
//        HStack{
//            Text("Level \(gameState.level)")
//                .font(.caption)
//            Spacer()
//            Text("$\(gameState.money, specifier: "%.2f")")
//                .font(.caption)
//        }
//        .padding([.leading,.trailing], 10)
            
        //TODO separate items from iventory vs store buy
        List(storeItems.storeItems){
            item in
            
            //TODO
//            @State var disabled = item.price < gameState.money //error here
            @State var insufficientFunds = false
            
            HStack{
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("\(item.desc)")
                        .font(.caption)
                }
                Spacer()
                VStack{
                    //info icon to show detail view/usages/unlock/etc
                    if item.purchased || item.startingItem{
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.green)
                    }else{
                        if gameState.level >= item.levelUnlocked{
                            Button("$ \(item.price, specifier: "%.2f")", action: item.buy)
                                .background(insufficientFunds ? .gray : .green)
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .font(.subheadline)
                        }else{
                            Text("Required level")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text("\(item.levelUnlocked)")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                    }
                }
                .buttonStyle(.bordered)
                .cornerRadius(5)
                
//                Button("Sign In", systemImage: "arrow.up", action: item.buy)
//                    .labelStyle(.iconOnly)

            }
        }
    }
}

#Preview {
    StoreView()
}
