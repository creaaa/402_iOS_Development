
import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var taskDetailLabel: UILabel!
    
    var todo: Todo?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let todo = self.todo {
            self.taskDetailLabel.text =
                todo.title + " ," +
                todo.desc + " ,Priority: " +
                todo.priority.description + " ," +
                todo.deadLine.description
        }
    }
}
