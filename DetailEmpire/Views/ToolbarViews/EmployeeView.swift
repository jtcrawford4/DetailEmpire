import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        
        @State var employeeTypes = EmployeeType.allCases
        @State var maxEmployees = gameState.currentBuilding.workerSlots
        @State var payrollDue = gameState.payrollDue
//        @State var payrollDue = true
        @State var payrollOwed = gameState.getPayrollOwed()
        @State var insufficientFunds = payrollOwed > gameState.money
        @State var workersOnStrike = gameState.workersOnStrike
//        @State var workersOnStrike = true
        
        VStack{
            //TODO
            //payroll due banner, button to pay, button to open sheet for details
            
            
            if payrollDue {
                VStack{
                    HStack{
                        VStack{
                            Text("PAYROLL DUE")
                                .font(Font.custom("Oswald-Light", size: 20))
//                                .fontWeight(.regular)
                                .foregroundColor(.pink)
                            Divider()
                                .background(.red)
                                .padding(.vertical, -10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    VStack(alignment: .center){
                        ForEach(EmployeeType.allCases){ emp in
                            activeStatView(label: "\(emp.rawValue)", value: gameState.getPayrollOwedByEmployeeType(type: emp),  modifier: "$", color: .pink)
                        }
                        Divider()
                            .background(.white)
                        activeStatView(label: "TOTAL", value: gameState.getPayrollOwed(), modifier: "$", color: .pink)
                        if workersOnStrike {
                            Text("WORKERS ON STRIKE")
                                .font(Font.custom("Oswald-Light", size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.pink)
                        }
                        Button(action: {
                            gameState.money -= payrollOwed
                            gameState.payrollDue = false
                            gameState.vehiclesSincePayroll = 0
                            gameState.resetPayrollOwed()
                        }) {
                            VStack{
                                Text("PAY")
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 18)
                                    .frame(height: 20)
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                        .font(.system(size: 16))
                                    Text("\(payrollOwed, specifier: "%.2f")")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                            .font(Font.custom("Oswald-Light", size: 14))
                        }
                        .frame(minWidth: 85)
                        .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray] : [.pink, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(8)
                        .padding(.bottom, 4)
                        .foregroundColor(.white)
                        .disabled(insufficientFunds)
                        .shadow(color: Color.black.opacity(0.25), radius: 0, x: 0, y: 4)
                    }
                    .padding(.horizontal, 50)
                    .padding(.bottom, 6)
                }
                .background(.black.opacity(0.80))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2)
                )
                .padding([.horizontal, .bottom], 10)
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
                .brightness(0.2)
                
            }
//            VStack{
//                Text("employee metrics here")   
//            }
            VStack{
                HStack{
                    employeeListingView(type: EmployeeType.detailer)
                    employeeListingView(type: EmployeeType.generalManager)
                }
                HStack{
                    employeeListingView(type: EmployeeType.inventoryManager)
                    employeeListingView(type: EmployeeType.shopManager)
                }
            }
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
