import SwiftUI

struct WorkView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var vehicle: Vehicle
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var building: Building
    
    var body: some View {
        
        @State var detailDisabled = gameState.detailDisabled || vehicle.isCompleted()

        VStack{
            
            
            //
            VStack{
                HStack{
                    Image(systemName: "sparkle")
                        .padding(15)
                    Text("\(building.name)")
                        .font(.title)
                }
                .padding(.top, 10)
                HStack{
                    Text("desc")
                }
                HStack{
                    VStack{
                        BuildingStatView(headline: "Parking Spaces", value: building.vehicleSlots, color: .purple, image: "car.fill")
                            .padding(.trailing, 10)
                    }
                    VStack{
                        BuildingStatView(headline: "Max Employees", value: building.workerSlots, color: .pink, image: "person.fill")
                            .padding(.trailing, 10)
                    }
                    VStack{
                        BuildingStatView(headline: "Current Employees", value: building.employees.count, color: .cyan, image: "person.fill")
                    }
                }
//                .padding(.top, 15)
                .padding(30)
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.bottom, 10)
            
            VStack{
                HStack{
                    VStack{
                        Text("Vehicles")
                        Text("\(vehicle.type)")
//                        ProgressView(value: Float(Double(vehicle.percentComplete) / 100))
//                            .progressViewStyle(.linear)
//                            .padding(.horizontal, 150)
//                            .padding(.vertical, 20)
                    }
                    .padding(.leading, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    VStack{
                        Button(action: {
                            vehicle.detail(gameState: gameState, inventory: inventory.inventoryItems)
                        }, label: {
                            Text("Detail")
                        })
                        .foregroundColor(.white)
                        .padding()
                        .background(detailDisabled ? .gray : .black)
            //            .border(.white, width: 3).cornerRadius(8)
                        .cornerRadius(8)
                        .disabled(detailDisabled)
                    }
                }
                    
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding([.leading,.trailing], 10)
            
            //
            
            
            
            //debugging
//            Text("Building: \(building.name)")
//            Text("Vehicle slots: \(building.vehicleSlots)")
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
            .background(detailDisabled ? .gray : .black)
//            .border(.white, width: 3).cornerRadius(8)
            .cornerRadius(8)
            .disabled(detailDisabled)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.vertical)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
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

struct BuildingStatView:View {
    
    var headline: String
    var value: Int
    var color: Color
    var image: String
    
    var body: some View {
        VStack{
            Text("\(headline)")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
                .frame(width: 15, height: 2)
                .cornerRadius(4)
                .background(color)
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.bottom, -20)
            Gauge(value: 0.5) {}
                currentValueLabel: {
                    Image(systemName: "\(image)")
                        .foregroundColor(color)
                }
                .gaugeStyle(.accessoryCircular)
                .tint(color)
                .scaleEffect(0.5)
        }
    }
}
