import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")!
            
        ZStack{
            Image("test12")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.yellow.opacity(0.5), .black]), startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .opacity(0.4)
//                .foregroundStyle(.linearGradient(LinearGradient(colors: [.black,.white], startPoint: .topLeading, endPoint: .bottomTrailing), startPoint: .top, endPoint: .bottom))
            VStack{
                Spacer()
                VStack{
                    Divider()
                        .frame(width: 250, height: 2)
                        .cornerRadius(4)
                        .background(.white)
                        .padding(.bottom, -50)
                    Text("DETAIL EMPIRE")
                        .font(Font.custom("Oswald-Light", size: 62))
                        .fontWeight(.semibold)
//                        .padding(.vertical, -10)
//                        .foregroundColor(.black)
//                        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 6, y: 6)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white.opacity(0.4), .black, .black.opacity(0.8), .black, .white.opacity(0.4)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    Divider()
                        .frame(width: 250, height: 2)
                        .cornerRadius(4)
                        .background(.white)
                        .padding(.top, -25)
                }
                Spacer()
                VStack {
                    Button("CONTINUE", action: self.test)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.yellow.opacity(0.5))
                        .background(.black)
                        .disabled(true)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.yellow.opacity(0.5), lineWidth: 2)
                        )
                    Button("NEW GAME", action: self.openNewGame)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.yellow)
                        .background(.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.yellow, lineWidth: 2)
                        )
                        .padding(.vertical, 6)
                    Button("OPTIONS", action: self.openOptions)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.yellow)
                        .background(.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.yellow, lineWidth: 2)
                        )
                }
                .buttonStyle(.bordered)
                .font(Font.custom("Oswald-Light", size: 22))
                .fontWeight(.semibold)
                .padding(.horizontal, 100)
                
                Spacer()
                VStack{
                    Text("\(appVersion).\(buildNumber)")
                        .font(Font.custom("Oswald-Light", size: 14))
                        .foregroundColor(.yellow)
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
