
import UIKit

class Assignment9ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailViewController: TodoDetailViewController? = nil

    var todos: [Todo] = [
        Todo(title: "Shopping", desc: "Meat, Milk, Yogurt", priority: 4, isCompleted: false, deadLine: Date(timeIntervalSinceNow: 7200)),
        Todo(title: "Assignment 9", desc: "hard", priority: 2, isCompleted: false, deadLine: Date(timeIntervalSinceNow: -3600)),
        Todo(title: "Skype Meeting", desc: "with Katsu", priority : 5, isCompleted: true, deadLine: Date()),
        Todo(title: "Make Resume", desc: "hard", priority: 3, isCompleted: true, deadLine: Date(timeIntervalSinceNow: 14400)),
        Todo(title: "Appointment", desc: "with Xavier", priority: 1, isCompleted: true, deadLine: Date(timeIntervalSinceNow: -12800))
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
        
        self.todos.sort { return $0.priority < $1.priority }
        self.tableView.reloadData()
        
    }    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                self.todos.sort { return $0.priority < $1.priority }
                self.tableView.reloadData()
            case 1:
                self.todos.sort { return $0.deadLine < $1.deadLine }
                self.tableView.reloadData()
            default:
                fatalError("never executed")
        }
    }
}


extension Assignment9ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { return self.todos.filter{$0.isCompleted}.count }
        else { return self.todos.filter{$0.isCompleted == false}.count }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todos = indexPath.section == 0 ?
        self.todos.filter{ $0.isCompleted } : self.todos.filter{ $0.isCompleted == false }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell9
        
        cell.titleLabel.text = todos[indexPath.row].title
        cell.descLabel.text  = todos[indexPath.row].desc
        cell.priorityLabel.text = todos[indexPath.row].priority.description
        cell.isCompletedImageView.alpha = todos[indexPath.row].isCompleted ? 1 : 0
        cell.deadlineLabel.text = todos[indexPath.row].deadLine.description
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMaster", sender: indexPath)
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let targetTodo = self.todos[sourceIndexPath.row]
        
        let indexFrom = sourceIndexPath.row
        let indexTo   = destinationIndexPath.row

        self.todos.remove(at: indexFrom)
        self.todos.insert(targetTodo, at: indexTo)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Complete Todos" : "Imcomplete Todos"
    }
   
}





