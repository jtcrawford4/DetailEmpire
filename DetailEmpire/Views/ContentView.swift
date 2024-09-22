import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")!
            
        ZStack{
            Image("test34")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.pastelYellow.opacity(0.8), .black]), startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .opacity(0.7)
//                .foregroundStyle(.linearGradient(LinearGradient(colors: [.black,.white], startPoint: .topLeading, endPoint: .bottomTrailing), startPoint: .top, endPoint: .bottom))
            VStack{
                Spacer()
                VStack{
//                    Divider()
//                        .frame(width: 250, height: 1)
//                        .cornerRadius(4)
//                        .background(.white)
//                        .padding(.bottom, -50)
                    Image("logo")
                        .resizable()
                        .frame(width: 100,height: 100)
                    Text("DETAIL EMPIRE")
//                        .shadow(color: .white, radius: 5)
                        .font(Font.custom("Oswald-Light", size: 26))
                        .fontWeight(.light)
//                        .padding(.vertical, -10)
//                        .foregroundColor(.black)
//                        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 6, y: 6)
//                        .foregroundStyle(
//                            LinearGradient(
//                                colors: [.white.opacity(0.1), .black, .black,.black, .black, .white.opacity(0.1)],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        )
//                    Divider()
//                        .frame(width: 250, height: 1)
//                        .cornerRadius(4)
//                        .background(.white)
//                        .padding(.top, -25)
                }
                Spacer()
                VStack {
                    MenuButton(title: "CONTINUE", function: self.test, disabled: true)
                    MenuButton(title: "NEW GAME", function: self.openNewGame, disabled: false)
                        .padding(.vertical, 6)
                    MenuButton(title: "OPTIONS", function: self.openOptions, disabled: false)
                }
                Spacer()
                VStack{
                    Text("\(appVersion).\(buildNumber)")
                        .font(Font.custom("Oswald-Light", size: 14))
                        .foregroundColor(.pastelYellow)
                }
            }
        }
    }
    
    func test(){
        
    }
    
//    fix deprecated usages
    func openNewGame() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: GameView())
            window.makeKeyAndVisible()
        }
    }
    
    func openOptions() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: OptionsView())
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    ContentView()
}
