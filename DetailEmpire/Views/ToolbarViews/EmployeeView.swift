import SwiftUI

struct EmployeeView: View {
    
    @ObservedObject var gameState = GameState()
    
    var body: some View {
        VStack{
            Text("Employees")
                .padding(.vertical, 10)
                .font(.headline)
            //debug
            Text("hired: \(gameState.numEmployee)")
            HStack{
                List(EmployeeType.allCases){
                    type in
                    
                    let hireCost = getDefaultEmployeeHireCost(type: type.id)
                    @State var insufficientFunds = hireCost > gameState.money
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text(type.rawValue)
                                .font(.headline)
                        }
                        Spacer()
                        VStack{
                            Button("Hire", action:{
                                gameState.numEmployee += 1
                                gameState.money -= hireCost
                                gameState.employees.append(Employee(payPerVehicle: 1.00, hirePrice: hireCost, type: type))
                            })
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(insufficientFunds ? .gray : .blue)
                            .cornerRadius(6)
                            .disabled(insufficientFunds)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EmployeeView()
}
