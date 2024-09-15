import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        
        @State var employeeTypes = EmployeeType.allCases
        @State var maxEmployees = gameState.currentBuilding.workerSlots
        
        VStack{
            VStack{
                Text("employee metrics here")
                if gameState.currentBuilding.employees.count > 0 {
                    Text("(debug) pay owed [0]: \(gameState.currentBuilding.employees[0].payOwed)")
                }
            }
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
