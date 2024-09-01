import SwiftUI

struct WorkView: View {
    
    @ObservedObject var gameState = GameState()
    @ObservedObject var vehicle = Vehicles().getVehicle()
    //TODO timing
    
    var body: some View {
        
        //TODO do while loop get vehicles with cooldown
        VStack{
            Text("$\(gameState.money, specifier: "%.2f")")            
            Text("\(vehicle.type)")
            Text("Remaining: \(vehicle.clicksToComplete - vehicle.clicks)")
            Text("\(vehicle.percentComplete)%")
            Button(action: {
                vehicle.detail()
                if vehicle.isCompleted(){
                    gameState.money += vehicle.baseRevenue
                    gameState.xp += vehicle.xp
                    //TODO new vehicle
//                    vehicle = Vehicles.getVehicle()
                }
            }, label: {
                Text("Detail")
            })
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(8)
        }
    }
}

#Preview {
    WorkView()
}
