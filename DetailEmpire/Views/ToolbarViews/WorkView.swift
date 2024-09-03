import SwiftUI

struct WorkView: View {
    
    @ObservedObject var gameState = GameState()
    @ObservedObject var vehicle = Vehicles().getVehicle()
    @ObservedObject var inventory = InventoryItems()
    
    var body: some View {
        
        @State var detailDisabled = inventory.itemEmpty()
//        gameState.currentVehicle = vehicle

        VStack{
            //debugging
            Text("$\(gameState.money, specifier: "%.2f")")
            Text("xp next level: \(gameState.xpToNextLevel)")
            Text("\(vehicle.type)")
            Text("Remaining: \(Double(vehicle.clicksToComplete) - vehicle.clicks)")
            Text("\(vehicle.percentComplete)%")
            ProgressView(value: Float(Double(vehicle.percentComplete) / 100)) //TODO make circle?
                .progressViewStyle(.linear)
                .padding(.horizontal, 150)
                .padding(.vertical, 20)
            //
            Button(action: {
                vehicle.detail() //TODO should all go here?
                if vehicle.isCompleted(){
                    gameState.money += vehicle.baseRevenue
                    gameState.xp += vehicle.xp
                    for item in inventory.inventoryItems{
                        item.use()
                        if item.usesRemaining == 0 {
                            detailDisabled = true
                        }
                    }
                    if gameState.xp >= gameState.xpToNextLevel {
                        gameState.level += 1
                        gameState.xpToNextLevel = Int(round(Double(gameState.xpToNextLevel) * 2.8))
                    }
                }
            }, label: {
                Text("Detail")
            })
            .foregroundColor(.white)
            .padding()
            .background(detailDisabled ? .gray : .blue)
            .cornerRadius(8)
            .disabled(detailDisabled)
        }
    }
}

#Preview {
    WorkView()
}
