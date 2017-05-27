
import Foundation

struct City {
    
    enum Weather: Int, CustomStringConvertible {
        
        case sunny, cloudy, rainy
        
        var description: String { return self.rawValue.description }
        
        var currentTime: String {
            
            let times = ["4:00", "12:00", "20:00"]
            
            return times[self.rawValue]
            
        }
        
        var currentTemperature: Int { return self.rawValue * 9 }
        
        var chanceOfPrecipitation: Int { return self.rawValue * 50 }
        
        var weatherImgPath: String {
            
            switch self.rawValue {
            case 0:
                return "sunny"
            case 1:
                return "cloudy"
            case 2:
                return "rainy"
            default:
                fatalError("never executed")
            }
        }
        
    }
    
    let weather: Weather = Weather(rawValue: Int(arc4random_uniform(3)))!
    
}
