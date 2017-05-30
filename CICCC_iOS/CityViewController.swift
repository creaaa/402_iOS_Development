
import UIKit

class CityViewController: UIViewController {

    var city = City()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = .gray
        
        let imageView = UIImageView().apply {
            $0.image = UIImage(named: self.city.weather.weatherImgPath)
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let label = UILabel().apply {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            $0.text = self.city.weather.weatherImgPath
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let button = UIButton(type: .system).apply {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            $0.setTitle("Detail", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .purple
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTarget(self, action: #selector(moveToWeatherDetails), for: .touchUpInside)
        }
        
        self.view.addSubview(imageView)
        self.view.addSubview(label)
        self.view.addSubview(button)
        
        // add constaints
        
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -75).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive = true
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        
    }
    
    
    func moveToWeatherDetails() {
        
        let nextVC = DetailedViewController()
        
        //nextVC.view.tintColor = .yellow  // これエラー！
        // なぜならこの時点では cityがnilだからぬるぽになる → よく考えるとこの説明意味不明。結局謎。
        
        nextVC.city = self.city
        
        nextVC.view.tintColor = .yellow  // だからここに書け。ただしこれ意味発揮してない、なんで
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    deinit {
        print("deinited!!")
    }
    
}
