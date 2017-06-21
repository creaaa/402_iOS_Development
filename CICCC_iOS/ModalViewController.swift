
import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var dp:  UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismiss(sender: UIButton) {
        
        let title = tf1.text ?? ""
        let desc  = tf2.text ?? ""
        let pri   = tf3.text.flatMap{ Int($0) } ?? 0
        let date  = dp.date
        
        let todo = Todo(title: title, desc: desc, priority: pri, isCompleted: false, deadLine: date)
        
        print(todo)
        
        //呼び出し元のView Controllerを取得しパラメータを渡す
        let vc = ((self.presentingViewController as! UISplitViewController).viewControllers.first as! UINavigationController).viewControllers.first as! Assignment9ViewController
        print(vc)
        
        vc.todos.append(todo)

        dismiss(animated: true, completion: nil)
        
    }

}
