#  <#Title#>

//TODO
    - consolidate inventory/store item into UseableItem with enum for type
    - fontAwesome icons
    - dark gray (#3d4846)
    
//utils
    - MoneyText, always formatted for 2 decimals
    - contants file for multipliers, xpToNextLevel multiplication
    
//vehicle
    - unlock additional services that generate revenue
    - each vehicle has random chance of wanting 1 or more services
    
//building
    - rent?
    - price buy vs own
    - property taxes
    - electric/water bill

//items
    - capacity
        uses remaining 5/60, increase capacity for refill
            - percentage based instead? degrades slower?
    - rebuy
        buy multiple packs of soap i.e. 6 pack/50 gal drum
            price discount, multiple usages of item accordingly
    - percentage degrade for equipment
    - unlock ability to hold more items
    - upgrade item stars/color coding (common/rare/epic style), last longer, more money etc. special ability
    - equipment degrades, works slower after a threshold i.e. 20% works half as well, etc
    - classifieds section for buying used equipment
    - have multiple polishers for multiple bays/employees, etc
    - classifieds section for buying used equipment?
    - implement items that take longer to detail but have xp and money bonus

//Eventually
    finance
        options for load, interest rates/accuring
        
    color coding item list?
        category for items
        meta data for items
    - unlock specialty services/employee training
        - results in new items/soaps that must be used, etc
        
//Employee
    - each garage can accept up to so many employees? x general employee, x specialist, x manager
    - unlock to have more employees?
    - go on strike if not paid?
    - change 'general' to 'worker'
    - upgrades for shady business practices, pay less, pay under table, creative accounting etc
        - if any used, random chance of being busted by law, fined by agency, employee strike, employee quit
    - if payroll has been ignored
        - efficiency immediately takes place (gamestate penalty variable)
        - long enough then go on strike
        - long enough still and employees quit (employee hire cost does not change, built in penalty)
        
//Snippets

    //dialog button
    Button("", systemImage: "info.circle"){}
        .font(.system(size: 12))
        .padding(.leading, -10)
    .alert("Important message", isPresented: $showingItemInfo) {
        Button("OK", role: .cancel){}
    }
