
import UIKit

class CalcViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        billTextField.delegate = self
        
        let button = UIButton(type: .system).apply {
            $0.frame = CGRect.zero
            $0.titleLabel?.text = "こんにちは"
            $0.setTitleColor(.red, for: .normal)
            
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
    }
    
    
    @IBAction func tipPercentageChanged(_ sender: UISlider) {
        self.tipPercentageLabel.text = "Tip: " + Int(sender.value).description + "%"
        showTip(per: Int(sender.value))
    }
    
    
    // delegate method 
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        showTip(per: Int(tipPercentageSlider.value))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func showTip(per: Int) {
        
        if (billTextField.text?.isEmpty)! {
            self.tipAmountLabel.text = "$0"
            return
        }
        
        let totalTip = billTextField.text.flatMap{ Int($0) }! * per / 100
        
        self.tipAmountLabel.text = "Tip: $" + totalTip.description
        
    }
    
 
    @IBAction func resign(_ sender: UITapGestureRecognizer) {
        if(billTextField.isFirstResponder) {
            billTextField.resignFirstResponder()
        }
    }
    
}




