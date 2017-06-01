
import UIKit

class CanvasViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var drawmodeSegmentControl: UISegmentedControl!
    @IBOutlet weak var palletStackView: UIStackView!
    @IBOutlet weak var canvas: MyCanvas!
        
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    var previousPenColor: UIColor = .red
    
    
    override func viewDidLoad() {
        
        // 矩形に黒枠をつけるならこう
        // self.view.subviews[1].subviews[0].layer.borderWidth = 3
        self.palletStackView.subviews[0].layer.borderWidth = 3
        
        
        // colorPalletより送られる通知の監視
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: ColorPallet.notificationName,
            object: nil
        )
        
        self.configureObserver()
        
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
                self.canvas.penWidth = 35  // ないとダメ。↑で色変更した時点でwidthも変わってる
            
                self.palletStackView.isUserInteractionEnabled = false

            case 2:
                self.previousPenColor = self.canvas.penColor

                self.palletStackView.isUserInteractionEnabled = false
            
            default:
                print("fatal")
        }
        
    }
    
    
    /* notification */
    
    @objc // 選択された色パレットに枠線を加える
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
    
    
    
    // Notificationを設定
    func configureObserver() {
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(keyboardWillShow(notif:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        notification.addObserver(self, selector: #selector(keyboardWillHide(notif:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    // キーボードが現れた時に、画面全体をずらす。
    func keyboardWillShow(notif: Notification) {
        
        /*
        let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
        })
        */
        
        
        guard let info = notif.userInfo else {
            fatalError("unexpected notif")
        }
        
        guard let keyboardHeight = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {
            fatalError("No keyboard height found")
        }
        
        guard let animeDuration = info[UIKeyboardAnimationDurationUserInfoKey] as? CGFloat else {
            fatalError("No keyboard height found")
        }
        
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: TimeInterval(animeDuration)) {
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    
    // キーボードが消えたときに、画面を戻す
    
    func keyboardWillHide(notif: Notification) {
        
        /*
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            
            self.view.transform = CGAffineTransform.identity
        })
        */
        
        
        guard let info = notif.userInfo else {
            fatalError("unexpected notif")
        }
        
        guard let animeDuration = info[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            fatalError("No keyboard height found")
        }
        
        bottomConstraint.constant = 0
        
        UIView.animate(withDuration: animeDuration) { self.view.layoutIfNeeded() }
        
    }
    
    
    
    
    
    
    
    /* delegate method */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.backgroundColor = .black
        textField.textColor = .white
        
        textField.resignFirstResponder()
        return true
    }
    
}




