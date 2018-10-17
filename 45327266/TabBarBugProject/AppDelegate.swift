import UIKit

class CustomToolBar: UIToolbar {
    private let tabBar = UITabBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tabBar.items = [
            UITabBarItem(tabBarSystemItem: .topRated, tag: 0),
            UITabBarItem(tabBarSystemItem: .history, tag: 1),
            UITabBarItem(tabBarSystemItem: .favorites, tag: 2),
            UITabBarItem(tabBarSystemItem: .downloads, tag: 3),
            UITabBarItem(tabBarSystemItem: .more, tag: 4)]
        addSubview(tabBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(tabBar)
        tabBar.frame = bounds
    }
}

class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: nil, toolbarClass: CustomToolBar.self)
        setToolbarHidden(false, animated: false)
        setViewControllers([rootViewController], animated: false)
        
        // This is very simplified from the actual shipping code, but the insets here demonstrate the issue
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class ViewController : UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell()
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        return cell
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CustomNavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}
