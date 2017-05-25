
struct ConstraintDef {
    
    
    /////////////
    /// green ///
    /////////////
    
                               /* P   L   S */
    static let green_marginX = [340, 100, 325]
    static let green_width   = [350, 815, 400]
    
    static let green_marginY = [50,  200, 100]
    static let green_height  = [600, 250, 400]
    
    
    //////////////
    /// purple ///
    //////////////
    
                                /* P   L   S */
    static let purple_marginX = [-20, -20, -20]
    static let purple_width   = [100,100,100]
    
    static let purple_marginY = [-20,-20,-20]
    static let purple_height  = [50,50,50]
    
    
    
    
    static var greenViewDef: (marginX: [Int], width: [Int], marginY: [Int], height: [Int]) {
        return (green_marginX, green_width, green_marginY, green_height)
    }
    
    
    static var purpleViewDef: (marginX: [Int], width: [Int], marginY: [Int], height: [Int]) {
        return (marginX: purple_marginX, width: purple_width, marginY: purple_marginY, height: purple_height)
    }
    
    
    static func defByViewColorAndViewMode(viewColor: ViewController.ViewColor, viewMode: ViewController.ViewMode) -> (marginX: Int, width: Int, marginY: Int, height: Int) {

        let idx = viewMode.rawValue

        switch viewColor {
            
            case .green:
                return (greenViewDef.marginX[idx],
                        greenViewDef.width[idx],
                        greenViewDef.marginY[idx],
                        greenViewDef.height[idx])
            
            case .purple:
                return (purpleViewDef.marginX[idx],
                        purpleViewDef.width[idx],
                        purpleViewDef.marginY[idx],
                        purpleViewDef.height[idx])
        }
    }
}






