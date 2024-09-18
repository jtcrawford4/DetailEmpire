import SwiftUI

struct EmployeeHireView: View {
    var body: some View {
        ScrollView{
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
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeHireView()
        .environmentObject(gameState)
}
