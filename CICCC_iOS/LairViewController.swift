
import UIKit

class LairViewController: UIViewController {
    
    override func viewDidLoad() {
        
        // self.navigationItem.title = "Weird Lair"
        
        if self.navigationController?.viewControllers.count != 1 {
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "to start", style: .plain, target: self, action: #selector(toTop))]
            
        }
        
    }
    
    func toTop() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
