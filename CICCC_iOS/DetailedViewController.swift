
import UIKit

class DetailedViewController: UIViewController {
    
    var city: City!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // 「なんか」設定しないと、遷移時、黒い画面になりちらつく
        // SBからビューを参照しようとすることが原因だとか？
        self.view.backgroundColor = .white
        
        let currentTimelabel = UILabel(frame: .zero).apply {
            // $0.backgroundColor = .red
            $0.text = "Current Time: " + self.city.weather.currentTime.description + " "
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let currentTemperaturelabel = UILabel(frame: .zero).apply {
            // $0.backgroundColor = .red
            $0.text = "Temperature: " + self.city.weather.currentTemperature.description + "℃ "
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let chanceOfPrecipitationLabel = UILabel(frame: .zero).apply {
            // $0.backgroundColor = .red
            $0.text = "Precipitation: " + self.city.weather.chanceOfPrecipitation.description + "% "
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.view.addSubview(currentTimelabel)
        self.view.addSubview(currentTemperaturelabel)
        self.view.addSubview(chanceOfPrecipitationLabel)
        
        // add constraints
        currentTimelabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        currentTimelabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        
        currentTemperaturelabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        currentTemperaturelabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        chanceOfPrecipitationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        chanceOfPrecipitationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true

    }

}








