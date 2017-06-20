
import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismiss(sender: UIButton) {
        
        let title = tf1.text ?? ""
        let desc  = tf2.text ?? ""
        let pri   = tf3.text.map{ Int($0)! } ?? 0
        
        let todo = Todo(title: title, desc: desc, priority: pri, isCompleted: false)
        
        print(todo)
        
        //呼び出し元のView Controllerを取得しパラメータを渡す
        let vc = self.presentingViewController as! UISplitViewController // as! Assignment9ViewController
        print(vc.viewControllers.last)
        
        // vc.todos.append(todo)
        

        dismiss(animated: true, completion: nil)
        
    }

}
