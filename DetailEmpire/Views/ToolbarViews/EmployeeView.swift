import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var gameState: GameState
    @State private var selectedTab = 0
    
    var body: some View {
        
        @State var employeeTypes = EmployeeType.allCases
        @State var maxEmployees = gameState.currentBuilding.workerSlots

        VStack{
            Text("employee - add current metrics here")
            //TODO
            //payroll due banner, button to pay, button to open sheet for details
            HStack(spacing: 0){
                ToggleButton(selectedButton: $selectedTab, tag: 0, text: "HIRE")
                ToggleButton(selectedButton: $selectedTab, tag: 1, text: "TRAINING")
                ToggleButton(selectedButton: $selectedTab, tag: 2, text: "FINANCE")
//                    .badge(payrollDue ? "!" : nil) //TODO
            }
            .padding(.bottom, 40)
            
            switch(selectedTab){
                case 0:
                    EmployeeHireView()
                case 1:
                    EmployeeTrainingView()
                case 2:
                    EmployeeFinanceView()
                default:
                    EmployeeHireView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.green, .cyan],
             startPoint: .topLeading,
             endPoint: .bottomTrailing))
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
}
