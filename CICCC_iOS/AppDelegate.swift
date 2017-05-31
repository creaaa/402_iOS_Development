
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let hoge = 42

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // for assignment 1
        
        /*
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        */
        
        
        // for assignment 3

        /*
        
        var NavVCs: [UINavigationController] = []
        var VCs: [UIViewController] = []

        
        // VC 1
        let navVCfor1 = UINavigationController()
        navVCfor1.tabBarItem.image = UIImage(named: "City")
        navVCfor1.tabBarItem.title = "Vancouveraaaa"
        // navVCfor1.title = "バンクーバー"  // これコメントインすると、こっちがタブバーのタイトルになる
        
        let firstVC = CityViewController()
        firstVC.navigationItem.title = "Vancouver"
        firstVC.view.tag = 1
        
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        firstVC.tabBarItem.title = "Vancouver"
        
        navVCfor1.setViewControllers([firstVC], animated: true)
        
        NavVCs.append(navVCfor1)
        VCs.append(firstVC)

        
        // VC 2
        let navVCfor2 = UINavigationController()
        navVCfor2.tabBarItem.image = UIImage(named: "City")
        navVCfor2.tabBarItem.title = "Mexico"
        
        let secondVC = CityViewController()
        secondVC.navigationItem.title = "Mexico"
        secondVC.view.tag = 2
        
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        secondVC.tabBarItem.title = "Mexicorr"
        
        navVCfor2.setViewControllers([secondVC], animated: true)
        
        NavVCs.append(navVCfor2)
        VCs.append(secondVC)
        
        // VC 3
        let navVCfor3 = UINavigationController()
        navVCfor3.tabBarItem.image = UIImage(named: "City")
        navVCfor3.tabBarItem.title = "Seoul"
        
        let thirdVC = CityViewController()
        thirdVC.navigationItem.title = "Seoul"

        thirdVC.view.tag = 3
        
        // thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        // thirdVC.tabBarItem.title = "Seoul"
        
        navVCfor3.setViewControllers([thirdVC], animated: true)

        NavVCs.append(navVCfor3)
        VCs.append(thirdVC)
        
        // VC 4
        let navVCfor4 = UINavigationController()
        navVCfor4.tabBarItem.image = UIImage(named: "City")
        navVCfor4.tabBarItem.title = "Venice"
        
        let fourthVC = CityViewController()
        fourthVC.navigationItem.title = "Venice"
        fourthVC.view.tag = 4
        
        // fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 4)
        // fourthVC.tabBarItem.title = "Venice"
        
        navVCfor4.setViewControllers([fourthVC], animated: true)
        
        NavVCs.append(navVCfor4)
        VCs.append(fourthVC)

        
        // VC 5
        let navVCfor5 = UINavigationController()
        
        navVCfor5.tabBarItem.image = UIImage(named: "City")
        navVCfor5.tabBarItem.title = "Tokyo"
        
        let fifthVC = CityViewController()
        fifthVC.navigationItem.title = "Tokyo"
        fifthVC.view.tag = 5
        
        
        navVCfor5.setViewControllers([fifthVC], animated: true)
        
        NavVCs.append(navVCfor5)
        VCs.append(fifthVC)
        
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(NavVCs, animated: false)
 

        window = UIWindow(frame: UIScreen.main.bounds)  // これないと黒い画面になる...
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        // tabBarController.viewControllers = baseControllers.map { UINavigationController(rootViewController: $0)}

        // こう書くと一気にセットできる...確かに。すげえ
        // tabBarController.viewControllers = VCs.map{ UINavigationController(rootViewController: $0) }
         
        */  // end of Assignment3
        
        return true
 
    }
}

