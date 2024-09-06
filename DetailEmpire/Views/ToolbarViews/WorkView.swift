import SwiftUI

struct WorkView: View {
    
    @EnvironmentObject var gameState: GameState
//    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var vehicle: Vehicle
    @EnvironmentObject var inventory: InventoryItems
//    @ObservedObject var vehicle = Vehicles().getVehicle()
    
    var body: some View {
        
//        @ObservedObject var vehicle = gameState.currentVehicle
//        @StateObject var vehicle = gameState.currentVehicle
        
//        @State var detailDisabled = inventory.itemEmpty()
//        @ObservedObject var inventory = gameState.inventory
        @State var detailDisabled = gameState.detailDisabled

        VStack{
            //debugging
            Text("\(vehicle.type)")
            Text("Remaining: \(Double(vehicle.clicksToComplete) - vehicle.clicks, specifier: "%.2f")")
            Text("\(vehicle.percentComplete)%")
            ProgressView(value: Float(Double(vehicle.percentComplete) / 100))
                .progressViewStyle(.linear)
                .padding(.horizontal, 150)
                .padding(.vertical, 20)
            //
            Button(action: {
                vehicle.detail(gameState: gameState, inventory: inventory.inventoryItems)
//                if vehicle.isCompleted(){
//                    gameState.money += vehicle.baseRevenue
//                    gameState.xp += vehicle.xp
//                    for item in inventory.inventoryItems{
//                        item.use()
//                        if item.usesRemaining == 0 {
//                            detailDisabled = true //TODO
//                        }
//                    }
//                    if gameState.xp >= gameState.xpToNextLevel {
//                        gameState.level += 1
//                        gameState.xpToNextLevel = Int(round(Double(gameState.xpToNextLevel) * 2.8))
//                    }
//                }
            }, label: {
                Text("Detail")
            })
            .foregroundColor(.white)
            .padding()
            .background(detailDisabled || vehicle.isCompleted() ? .gray : .blue)
            .cornerRadius(8)
            .disabled(detailDisabled || vehicle.isCompleted())
        }
    }
}

#Preview {
    WorkView()
}
