//
//  SceneDelegate.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/2/22.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let database = DatabaseDataSource()
    
    override init() {
        super.init()
        database.initDatabase { error in
            if let error = error {
                print(error)
                return
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let authViewModel = AuthenticationViewModel()
        authViewModel.signIn()
        
        if authViewModel.state == .signedIn {
            window.rootViewController = self.setViewControllers(self.database)
        } else {
            window.rootViewController = self.redirectToLogin(with: authViewModel)
        }
        window.makeKeyAndVisible()
//        self.write(to: database)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
extension SceneDelegate {
    private func redirectToLogin(with viewModel: AuthenticationViewModel) -> UIViewController {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.viewModel = viewModel
        welcomeViewController.viewModel?.delegate = self
        return welcomeViewController
    }
    private func setViewControllers(_ database: DatabaseDataSource) -> UIViewController {
        let foodRecordViewController = FoodRecordViewController()
        foodRecordViewController.viewModel = FoodRecordViewModel(on: AppDate(), database)
        
        let exerciseViewController = ExerciseViewController()
        exerciseViewController.viewModel = ExerciseViewModel(database: database)
        
        let progressViewController = ProgressViewController()
        progressViewController.viewModel = ProgressViewModel(database: database)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            foodRecordViewController.embedInNavgationController(),
            exerciseViewController.embedInNavgationController(),
            progressViewController.embedInNavgationController(),
        ]
        return tabBarController
    }
}
extension SceneDelegate: AuthenticationViewModelDelegate {
    func authenticationViewModelDidSignInSuccessfully(_ viewModel: AuthenticationViewModel) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = setViewControllers(database)
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    private func write(to database: DatabaseDataSource) {
//        let foodItems: [FoodItemEntry] = []
//        database.writeData(for: foodItems) { error in
//            if let error = error {
//                print(error)
//                return
//            }
//        }
        let dayRecord = DailyRecordEntry(date: AppDate(),
                                         meals: [
                                            MealEntry(name: "breakfast",
                                                      foodList: [
                                                        MealFoodRecordEntry(foodID: "food-egg-redmart", portion: 4, unit: "large (50g)"),
                                                        MealFoodRecordEntry(foodID: "food-shredded-mozzarella-tradition", portion: 100, unit: "gram"),
                                                      ]),
                                            MealEntry(name: "lunch",
                                                      foodList: [
                                                        MealFoodRecordEntry(foodID: "food-minced-beef-grassfed-85-15-master-grocer", portion: 200, unit: "gram"),
                                                        MealFoodRecordEntry(foodID: "food-cream-cheese-philadelphia", portion: 100, unit: "gram"),
                                                      ]),
                                            MealEntry(name: "dinner",
                                                      foodList: [
                                                        
                                                      ]),
                                         ],
                                         goalMacro: Macro(macro: DailyRecordEntry.defaultGoal))
        database.writeData(for: dayRecord) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
