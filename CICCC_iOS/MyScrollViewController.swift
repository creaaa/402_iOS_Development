
import UIKit

class MyScrollViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.view.bounds.origin.y += 100
        
    }
    
    
    @IBAction func panned(_ sender: UIPanGestureRecognizer) {
        
        //移動量を取得する。
        let move: CGPoint = sender.translation(in: view)
        
        //ドラッグした部品の座標に移動量を加算する。
//        sender.view!.center.x += move.x
        sender.view!.center.y += move.y
                
        //移動量を0にする。
        sender.setTranslation(CGPoint.zero, in: view)
        
    }
    
    
    
}
