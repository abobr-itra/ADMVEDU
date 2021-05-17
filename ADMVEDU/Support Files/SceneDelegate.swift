import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo _: UISceneSession,
	           options _: UIScene.ConnectionOptions)
	{
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()

		let homeVC = HomeViewController()
		let button = UITabBarItem(tabBarSystemItem: .search, tag: 1)
		homeVC.tabBarItem = button
		window?.rootViewController = UINavigationController(rootViewController: homeVC)
	}
}
