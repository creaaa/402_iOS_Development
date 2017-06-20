
import UIKit

class Assignment9ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var detailViewController: TodoDetailViewController? = nil

    var todos: [Todo] = [
        Todo(title: "Shopping", desc: "Meat, Milk, Yogurt", priority: 4, isCompleted: true),
        Todo(title: "Assignment 9", desc: "hard", priority: 2, isCompleted: false),
        Todo(title: "Skype Meeting", desc: "with Katsu", priority : 5, isCompleted: false),
        Todo(title: "Make Resume", desc: "hard", priority: 3, isCompleted: true),
        Todo(title: "Appointment", desc: "with Xavier", priority: 1, isCompleted: false)
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? TodoDetailViewController
        }
        
    }
    
    func addTask() {
        
        let sb = UIStoryboard(name: "Assignment9", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Modal")
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = (segue.destination as! UINavigationController).viewControllers[0] as! TodoDetailViewController
        vc.todo = todos[(sender as! IndexPath).row]
    }
    
}


extension Assignment9ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell9
        
        cell.titleLabel.text = todos[indexPath.row].title
        cell.descLabel.text  = todos[indexPath.row].desc
        cell.priorityLabel.text = todos[indexPath.row].priority.description
        cell.isCompletedImageView.alpha = todos[indexPath.row].isCompleted ? 1 : 0
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toMaster", sender: indexPath)
        
        
        // It's OK.
        
        /*
        guard let sb = self.storyboard else { return }
        
        guard let vc = sb.instantiateViewController(withIdentifier: "Master") as? TodoDetailViewController else { return }
        
        vc.todo = todos[indexPath.row]
        
        // モーダル遷移となる
        self.present(vc, animated: true, completion: nil)
        */
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
   
}












