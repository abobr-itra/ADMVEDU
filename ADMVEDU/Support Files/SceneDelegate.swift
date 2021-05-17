import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()

        let searchVC = HomeViewController()
        let button = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchVC.tabBarItem = button

        self.window?.rootViewController = UINavigationController(rootViewController: searchVC)
    }


		let homeVC = HomeViewController()
		let button = UITabBarItem(tabBarSystemItem: .search, tag: 1)
		homeVC.tabBarItem = button
		window?.rootViewController = UINavigationController(rootViewController: homeVC)
	}
}
