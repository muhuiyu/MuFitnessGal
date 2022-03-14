//
//  AlertSingleTextFieldTwoActionsController.swift
//  Lango
//
//  Created by Mu Yu on 9/2/21.
//

//import UIKit
//
//class AlertSingleTextFieldTwoActionsController: UIAlertController {
//
//    var leftActionType: AlertActionType? {
//        didSet {
//            guard let type = leftActionType else { return }
//            addAction(alertAction(setAsType: type))
//        }
//    }
//    var rightActionType: AlertActionType? {
//        didSet {
//            guard let type = rightActionType else { return }
//            addAction(alertAction(setAsType: type))
//        }
//    }
//    var leftTapHandler: (() -> Void)?
//    var rightTapHandler: (() -> Void)?
//    enum AlertActionType {
//        case cancel
//        case add
//        case ok
//        case save
//    }
//    func alertAction(setAsType type: AlertActionType) -> UIAlertAction {
//        switch type {
//        case .add:
//            return UIAlertAction(title: "Add", style: .default) { (_) in
//                guard
//                    let alertTextFields = alert.textFields,
//                    let inputValue = alertTextFields[0].text
//                else { return }
//                retir
//            }
//        case .cancel:
//            return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        case .ok:
//            return UIAlertAction(title: "OK", style: .default, handler: nil)
//        }
//    }
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nil, bundle: nil)
//
//        addAction(<#T##action: UIAlertAction##UIAlertAction#>)
//
//        alert.addTextField(configurationHandler: nil)
//        let addAction = UIAlertAction(title: "Add", style: .default, handler: { action in
//            guard
//                let alertTextFields = alert.textFields,
//                let inputValue = alertTextFields[0].text
//            else { return }
//
//            self.updateStackView(itemForRowAt: indexPath, setValueAs: inputValue, isFilled: true)
//            self.dismiss(animated: true, completion: nil)
//        })
//        addAction.isEnabled = false
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//            self.dismiss(animated: true, completion: nil)
//        })
//        alert.addAction(addAction)
//        alert.addAction(cancelAction)
//
//        NotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object:alert.textFields?[0],
//                                                              queue: OperationQueue.mainQueue()) { (notification) -> Void in
//
//            let textField = alert.textFields?[0] as! UITextField
//            saveAction.enabled = !textField.text.isEmpty
//        }
//
//
//        present(alert, animated: true, completion: nil)
//    }
//}
