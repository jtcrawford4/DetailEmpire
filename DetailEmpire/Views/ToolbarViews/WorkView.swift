import SwiftUI

struct WorkView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var vehicle: Vehicle
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var building: Building
    
    var body: some View {
        
        @State var detailDisabled = gameState.detailDisabled || vehicle.isCompleted()

        VStack{
            //Building Stats
            VStack{
                HStack{
                    Image(systemName: "house.fill")
                        .padding(10)
                        .font(.system(size: 40))
//                        .border(.cyan, width: 2)
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(8)
//                        .frame(alignment: .leading)
//                    Spacer()
                    VStack{
                        Text("\(building.name)")
                            .font(.title)
                        Divider()
                            .frame(width: 15, height: 2)
                            .cornerRadius(4)
                            .background(.orange)
                            .padding(.vertical, -10)
                    }
                }
                .padding(.top, 10)
//                .frame(alignment: .leading)
                VStack{
                    Text("desc")
//                    Text("XP: \(gameState.xp)/\(gameState.xpToNextLevel)")
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
                .padding([.leading,.trailing], 30)
                .padding(.vertical, 10)
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.bottom, 10)
            .padding(.top, -250)
            
            //Vehicles
            VStack{
                HStack{
                    VStack{
                        Text("Current Vehicles")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Divider()
                            .frame(width: 15, height: 2)
                            .cornerRadius(4)
                            .background(.purple)
                            .padding(.vertical, -4)
                            .padding(.horizontal, -45)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                HStack{
                    VStack{
                        Text("\(vehicle.type.uppercased())")
                            .font(.headline)
                            .padding(.trailing, 10)
                        ProgressView(value: Float(Double(vehicle.percentComplete) / 100))
                            .progressViewStyle(.linear)
                            .padding(.horizontal, 4)
                            .padding(.trailing, 20)
                            .tint(.purple)
                    }
                    Spacer()
                    HStack{
                        VStack{
                            VehicleStatView(headline: "XP", value: "\(vehicle.xp)", color: .green)
                        }
                        .padding(.trailing, 10)
                        VStack{
                            VehicleStatView(headline: "Earnings", value: "$\(Formatting().formatPrice(num: vehicle.baseRevenue))", color: .green)
                        }
//                        .padding(.trailing, 10)
//                        VStack{
//                            VehicleStatView(headline: "Bonus", value: "$0", color: .orange)
//                        }
                    }
                    Spacer()
                    Spacer()
                    VStack{
                        Button(action: {
                            vehicle.detail(gameState: gameState, inventory: inventory.inventoryItems)
                        }, label: {
                            Text("Detail")
                                .fontWeight(.bold)
                                .font(.subheadline)
                        })
                        .foregroundColor(.white)
                        .padding(10)
                        .background(detailDisabled ? .gray : .green)
                        .cornerRadius(8)
                        .disabled(detailDisabled)
                        .padding([.vertical,.trailing], 6)
                    }
                    Spacer()
                }
                    
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding([.leading,.trailing], 10)
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
                .font(.callout)
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

struct VehicleStatView:View {
    
    var headline: String
    var value: String
    var color: Color
//    var image: String
    
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
                .background(.black)
            Text("\(value)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(color)
//            Gauge(value: 0.5) {}
//                currentValueLabel: {
//                    Image(systemName: "\(image)")
//                        .foregroundColor(color)
//                }
//                .gaugeStyle(.accessoryCircular)
//                .tint(color)
//                .scaleEffect(0.5)
        }
    }
}
