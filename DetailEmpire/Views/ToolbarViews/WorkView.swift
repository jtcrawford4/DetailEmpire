import SwiftUI

struct WorkView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var vehicle: Vehicle
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var building: Building
    
    var body: some View {
        
        @State var detailDisabled = gameState.detailDisabled || vehicle.isCompleted()

        VStack{
            //debugging
            Text("Building: \(building.name)")
            Text("Vehicle slots: \(building.vehicleSlots)")
            Text("XP: \(gameState.xp)/\(gameState.xpToNextLevel)")
            Text("\(vehicle.type)")
            Text("Remaining: \(Double(vehicle.clicksToComplete) - vehicle.clicks, specifier: "%.2f")")
            Text("\(vehicle.percentComplete)%")
//            Image("icons8-car-cleaning-50")
            ProgressView(value: Float(Double(vehicle.percentComplete) / 100))
                .progressViewStyle(.linear)
                .padding(.horizontal, 150)
                .padding(.vertical, 20)
            //
//            if vehicle.getVehicleImageName() != "" {
//                Image(vehicle.getVehicleImageName())
//            }else{
//                .background(
//                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading)
//                )
//            }
            Button(action: {
                vehicle.detail(gameState: gameState, inventory: inventory.inventoryItems)
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
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return WorkView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
        .environmentObject(gameState.currentBuilding)
}
