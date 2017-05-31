
import UIKit

class CanvasViewController: UIViewController {

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
                // これもないとダメ。↑で色変更した時点でwidthも変わってる
                self.canvas.penWidth = 25
            
                self.palletStackView.isUserInteractionEnabled = false

            case 2:
                print("2")
            default:
                print("fatal")
        }
        
    }
    
    
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
    
}
