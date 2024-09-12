import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var gameState: GameState
//    var employeeTypes = EmployeeType.allCases
    
    var body: some View {
        
        @State var employeeTypes = EmployeeType.allCases
        @State var maxEmployees = gameState.currentBuilding.workerSlots
        
        VStack{
            Spacer()
            VStack{
                Text("employee metrics here")
            }
//            Spacer()
            HStack{
                ForEach(employeeTypes){ type in
                    
                    let hirePrice = Employee.getNextEmployeeHireCost(employees: gameState.currentBuilding.employees, type: type)
//                    @State var insufficientFunds = hirePrice > gameState.money
                    @State var buildingHasCapacity = gameState.currentBuilding.employees.count < gameState.currentBuilding.workerSlots
                    @State var insufficientFunds = false
//                    @State var buildingHasCapacity = false
                    Spacer()
                    VStack{
                        Text("\(type)").textCase(.uppercase)
                            .font(Font.custom("Oswald-Light", size: 18))
                            .foregroundColor(.white)
//                            .padding(.top, 4)
//                            .fontWeight(.semibold)
                        Image(systemName: "person.fill")
                            .font(.system(size: 60))
                            .foregroundColor(!buildingHasCapacity ? .gray.opacity(0.5) : type == EmployeeType.general ? .blue : .orange)
                            .padding(.top, 2)
                            .padding(.bottom, 6)
                        VStack{
                            if buildingHasCapacity {
                                Button(action: {
                                    gameState.money -= hirePrice
                                    gameState.currentBuilding.employees.append(Employee(payPerVehicle: 1.00, hirePrice: 2.00, type: EmployeeType.general))
                                }) {
                                    VStack{
                                        Text("HIRE")
                                            .fontWeight(.semibold)
                                        HStack {
                                            Image(systemName: "dollarsign.circle")
                                                .font(.system(size: 16))
                                            Text("\(Formatting.formatPrice(num: hirePrice))")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .font(Font.custom("Oswald-Light", size: 14))
                                }
                                .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray] : [.green, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(8)
                                .padding(2)
                                .padding(.bottom, 4)
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .buttonStyle(.bordered)
//                                .shadow(color: Color.black.opacity(0.55), radius: 2, x: 0, y: 6)
                            }else{
                                Text("CAPACITY LIMIT")
                                    .font(Font.custom("Oswald-Light", size: 14))
                                    .foregroundColor(.red)
//                                    .font(Font.custom("Oswald-Light", size: 14))
//                                    .foregroundColor(.red)
//                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                Text("\(gameState.currentBuilding.employees.count) / \(gameState.currentBuilding.workerSlots)")
                                    .font(Font.custom("Oswald-Light", size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(LinearGradient(gradient: Gradient(colors: !buildingHasCapacity ? [.gray, .black.opacity(0.5)] : type == EmployeeType.general ? [.cyan, .blue] : [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
                }
                Spacer()
            }
                .padding(.top, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.vertical)
        .background(LinearGradient(colors: [.green, .cyan],
             startPoint: .topLeading,
             endPoint: .bottomTrailing))
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeView()
        .environmentObject(gameState)
}
