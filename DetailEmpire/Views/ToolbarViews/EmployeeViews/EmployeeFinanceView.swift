import SwiftUI

struct EmployeeFinanceView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        
        @State var payrollOwed = gameState.getPayrollOwed()
//        @State var payrollDue = gameState.payrollDue
//        @State var payrollDue = true
        @State var workersOnStrike = gameState.workersOnStrike
        @State var insufficientFunds = payrollOwed > gameState.money
        
        ScrollView{
//            if payrollDue {
                VStack{
                    HStack{
                        VStack{
                            Text("PAYROLL")
                                .font(Font.custom("Oswald-Light", size: 20))
                                .foregroundColor(.mint)
                            Divider()
                                .background(.white)
                                .padding(.vertical, -10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    VStack(alignment: .center){
                        ForEach(EmployeeType.allCases){ emp in
                            activeStatView(label: "\(emp.rawValue)".uppercased(), value: gameState.getPayrollOwedByEmployeeType(type: emp),  modifier: "$", color: .pink)
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
//            }
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeFinanceView()
        .environmentObject(gameState)
}
