import Foundation

class Formatting {
    
    static func formatPrice(num: Double) -> String{
        var thisNum = num
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum.roundToPlaces(places: 1)))K")
            }
            return("\(thousandNum.roundToPlaces(places: 1))K")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum.roundToPlaces(places: 1)))K")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(thisNum.roundToPlaces(places: 2)))")
            }
            return ("\(thisNum.roundToPlaces(places: 2))")
        }
    }
    
}
