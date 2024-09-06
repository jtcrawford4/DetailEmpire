import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var gameState: GameState
//    var employeeTypes = EmployeeType.allCases
    
    var body: some View {
        
        @State var employeeTypes = EmployeeType.allCases
        
        VStack{
            Text("Employees")
                .padding(.vertical, 10)
                .font(.headline)
            //debug
            Text("hired: \(gameState.employees.count)")
            HStack{
                
//                let hireCost = Employee.getDefaultEmployeeHireCost(type: EmployeeType.general)
                let hireCost = 1.00
                @State var insufficientFunds = hireCost > gameState.money
//                
                Button("Hire", action:{
//                    gameState.numEmployee += 1
                    gameState.money -= hireCost
                    gameState.employees.append(Employee(payPerVehicle: 1.00, hirePrice: hireCost, type: EmployeeType.general))
                })
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(insufficientFunds ? .gray : .blue)
                .cornerRadius(6)
                .disabled(insufficientFunds)
                
                
                
                
//                List (selection: employeeTypes) { type in
////                    let hireCost = Employee.getDefaultEmployeeHireCost(type: type)
//                    let hireCost = 1.00
//                    @State var insufficientFunds = hireCost > gameState.money
//                    
//                    HStack{
//                        VStack(alignment: .leading) {
//                            Text(type.id)
//                                .font(.headline)
//                        }
//                        Spacer()
//                        VStack{
//                            Button("Hire", action:{
//                                gameState.numEmployee += 1
//                                gameState.money -= hireCost
//                                gameState.employees.append(Employee(payPerVehicle: 1.00, hirePrice: hireCost, type: type))
//                            })
//                            .buttonStyle(.bordered)
//                            .foregroundColor(.white)
//                            .background(insufficientFunds ? .gray : .blue)
//                            .cornerRadius(6)
//                            .disabled(insufficientFunds)
//                        }
//                    }
//                }
            }
        }
    }
}

#Preview {
    EmployeeView()
}
