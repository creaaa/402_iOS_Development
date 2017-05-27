
import UIKit

class NavigationController: UINavigationController {


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // これは意味あるが...
        self.navigationBar.backgroundColor = .red
        
        // これらは意味なかった、ちくしょう。。。
        self.navigationItem.title = "Weird Lair"
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "to start", style: .plain, target: self, action: #selector(toTop))]
    }
    
    
    func toTop() {
        print("hoge-hoge-")
    }

}
