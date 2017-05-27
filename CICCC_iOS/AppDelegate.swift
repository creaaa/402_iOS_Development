
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let hoge = 42

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // for assignment 1
        /*
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKey()
        */
        
        
        // for assignment 3

        /*
        var NavVCs: [UINavigationController] = []
        var VCs: [UIViewController] = []

        
        // VC 1
        let navVCfor1 = UINavigationController()
        navVCfor1.tabBarItem.image = UIImage(named: "City")
        navVCfor1.tabBarItem.title = "Vancouver"
        // navVCfor1.title = "バンクーバー"  // これコメントインすると、こっちがタブバーのタイトルになる
        
        let firstVC = CityViewController()
        firstVC.navigationItem.title = "Vancouver"
        firstVC.view.tag = 1
        
        // firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        // firstVC.tabBarItem.title = "Vancouver"
        
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
        
        // secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        // secondVC.tabBarItem.title = "Mexicorr"
        
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
        
        // fifthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 5)
        // fifthVC.tabBarItem.title = "Tokyo"
        
        navVCfor5.setViewControllers([fifthVC], animated: true)
        
        NavVCs.append(navVCfor5)
        VCs.append(fifthVC)
        
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(NavVCs, animated: false)
 

        window = UIWindow(frame: UIScreen.main.bounds)  // これないと黒い画面になる...
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        /*
        // ページを格納する配列
        var viewControllers: [UIViewController] = []
        
        // 1ページ目になるViewController
        // let firstSB = UIStoryboard(name: "First", bundle: nil)
        // let firstVC = firstSB.instantiateInitialViewController()! as UIViewController
        
        let firstVC = UIViewController()
        
        
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        viewControllers.append(firstVC)
        
        
        /*
        // 2ページ目になるViewController
        let secondSB = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = secondSB.instantiateInitialViewController()! as UIViewController
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        viewControllers.append(secondVC)
        
        
        // 3ページ目になるViewController
        let thirdSB = UIStoryboard(name: "Third", bundle: nil)
        let thirdVC = thirdSB.instantiateInitialViewController()! as UIViewController
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        viewControllers.append(thirdVC)
        */
        
        
        // ViewControllerをセット
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(viewControllers, animated: false)
        
        
        // rootViewControllerをUITabBarControllerにする
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        */
 
        */
        
        // for 4
 
        return true
 
    }
}








