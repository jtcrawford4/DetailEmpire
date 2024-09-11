#  <#Title#>

//TODO
    - consolidate inventory/store item into UseableItem with enum for type
    - fontAwesome icons
    
//utils
    - MoneyText, always formatted for 2 decimals
    - contants file for multipliers, xpToNextLevel multiplication
    
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
        
        
//Snippets

    //dialog button
    Button("", systemImage: "info.circle"){}
        .font(.system(size: 12))
        .padding(.leading, -10)
    .alert("Important message", isPresented: $showingItemInfo) {
        Button("OK", role: .cancel){}
    }
