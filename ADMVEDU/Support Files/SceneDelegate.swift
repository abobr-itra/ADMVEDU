import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo _: UISceneSession,
	           options _: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else {
			return
		}
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()

		let searchVC = HomeViewController()
		let button = UITabBarItem(tabBarSystemItem: .search, tag: 1)
		searchVC.tabBarItem = button
		let loginVC = SignUpViewController()

		window?.rootViewController = UINavigationController(rootViewController: loginVC)

	}
}
