
import UIKit

class CityViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = arc4random_uniform(2) == 0 ? .cyan: .yellow
        
        // self.tabBarItem.title = "not displayed"
        
        let button = UIButton(type: .system).apply {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            $0.setTitle("move", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .purple
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTarget(self, action: #selector(howWeatherDetails), for: .touchUpInside)
        }
        
        self.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    func howWeatherDetails() {
        let nextVC = DetailedViewController()
        nextVC.no = self.view.tag
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
