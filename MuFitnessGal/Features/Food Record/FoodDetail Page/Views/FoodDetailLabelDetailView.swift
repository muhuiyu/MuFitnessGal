//
//  FoodDetailLabelDetailView.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import UIKit

class FoodDetailLabelDetailView: UIView {
    private let textField = UITextField()
    private let containerView = UIView()
    private let pickerView = CustomPickerView()
    private let pickerAccessory = UIToolbar()
    
    var viewModel: FoodDetailLabelDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            textField.text = viewModel.textLabelText
            pickerView.data = viewModel.pickerViewData
            
            if viewModel.cellType == .selection {
                textField.inputAccessoryView = pickerAccessory
            }
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension FoodDetailLabelDetailView {
    @objc
    func didSelectItemFromPickerView(_ picker: CustomPickerView) {
        textField.resignFirstResponder()
        print(pickerView.selectedValue)
        textField.text = pickerView.selectedValue
    }
    @objc
    func didDismissPickerView(_ picker: CustomPickerView) {
        textField.resignFirstResponder()
    }
}
// MARK: - View Config
extension FoodDetailLabelDetailView {
    private func configureViews() {
        pickerAccessory.autoresizingMask = .flexibleHeight
        pickerAccessory.barStyle = .default
        pickerAccessory.isTranslucent = false
        pickerAccessory.frame.size.height = 44
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didDismissPickerView(_:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectItemFromPickerView(_:)))
        pickerAccessory.items = [cancelButton, flexSpace, doneButton]
        
        textField.textAlignment = .right
        textField.font = UIFont.bodyBold
        textField.textColor = UIColor.systemBlue
        textField.inputView = pickerView
        textField.delegate = self
//        textField.returnKeyType = .default
//        textField.addTarget(self, action: #selector(didTapTextField), for: .allTouchEvents)
//        textField.addTarget(self, action: #selector(textFieldValueDidChange), for: .allEditingEvents)
        containerView.addSubview(textField)
        
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.borderWidth = 1
        addSubview(containerView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        textField.snp.remakeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(Constants.spacing.small)
            make.leading.equalToSuperview().inset(Constants.spacing.large)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
// MARK: - TextField Delegate
extension FoodDetailLabelDetailView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
