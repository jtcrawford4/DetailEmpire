import SwiftUI

struct StoreEquipmentView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    
    var body: some View {
        
        ScrollView{
            ForEach(storeItems.storeItems){ item in
                
                if item.type == InventoryItem.InventoryType.equipment {
                    @State var insufficientFunds = item.price > gameState.money
                    
                    HStack{
                        VStack{
                            ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .green, imageColor: .white)
                        }
                        .padding(.trailing, 6)
                        VStack(alignment: .leading){
                            Text("\(item.name.uppercased())")
//                                .font(.headline)
                                .font(Font.custom("Oswald-Light", size: 18))
                                .fontWeight(.semibold)
                            Text("\(item.desc)")
                                .font(Font.custom("Oswald-Light", size: 12))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack{
                            //info icon to show detail view/usages/unlock/etc
                            if item.purchased || item.startingItem {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.green)
                            }else{
                                if gameState.level >= item.levelUnlocked{
                                    Button(action: {
                                        gameState.money -= item.price
                                        item.purchased = true
                                        inventory.addItem(item: item)
                                    }) {
                                        VStack{
                                            Text("Purchase")
                                                .font(.caption2)
//                                                .font(Font.custom("Oswald-Light", size: 12))
                                                .fontWeight(.bold)
                                            HStack {
                                                Image(systemName: "dollarsign.circle")
                                                Text("\(item.price, specifier: "%.2f")")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    .background(insufficientFunds ? .gray : .green)
                                    .foregroundColor(.white)
                                    .disabled(insufficientFunds)
                                    .font(.subheadline)
                                    .cornerRadius(8)
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
                    }
                    .padding(.horizontal, 10)
                    .frame(height : 60)
                    .background(.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
                }
            }
        }
        .contentMargins(.horizontal, 10, for: .scrollContent)
//            .contentMargins(.vertical, 10, for: .scrollContent)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return StoreEquipmentView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.inventory)
}
