
import UIKit

class CanvasViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var drawmodeSegmentControl: UISegmentedControl!
    @IBOutlet weak var palletStackView: UIStackView!
    @IBOutlet weak var canvas: MyCanvas!
    
    var previousPenColor: UIColor = .red
    
    override func viewDidLoad() {
        
        // 矩形に黒枠をつけるならこう
        self.view.subviews[1].subviews[0].layer.borderWidth = 3
        
        // colorPalletより送られる通知の監視
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: ColorPallet.notificationName,
            object: nil
        )
        
        
    }
    
    
    @IBAction func drawModeChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                self.canvas.penColor = self.previousPenColor
                self.canvas.penWidth = 3
            
                self.palletStackView.isUserInteractionEnabled = true

            case 1:
                self.previousPenColor = self.canvas.penColor
                self.canvas.penColor = .black
                self.canvas.penWidth = 25  // ないとダメ。↑で色変更した時点でwidthも変わってる
            
                self.palletStackView.isUserInteractionEnabled = false

            case 2:
                self.previousPenColor = self.canvas.penColor

                self.palletStackView.isUserInteractionEnabled = false

            
            default:
                print("fatal")
        }
        
    }
    
    
//    func addTextField() {
//        
//        let textField = UITextField().apply {
//            $0.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
//            $0.backgroundColor = .gray
//            $0.textColor = .white
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//        
//        self.view.addSubview(textField)
//        
//        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        
//        textField.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        
//        textField.delegate = self
//    }
    
    /* notification */
    
    @objc
    func handleNotification(_ notification: Notification) {
        
        self.palletStackView.subviews.forEach {
            ($0 as! ColorPallet).isSelected = false
        }
        
        let info = notification.userInfo
        
        self.canvas.penColor = (info!["sender"] as! UIView).backgroundColor!
        (info!["sender"] as! ColorPallet).isSelected = true
        
        (self.palletStackView.subviews as! [ColorPallet]).forEach {
            $0.addBorderWidth()
            // $0.setNeedsDisplay()
        }
        
    }
    
    /* delegate method */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.backgroundColor = .black
        textField.textColor = .white
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
}











