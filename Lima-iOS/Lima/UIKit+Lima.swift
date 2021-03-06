//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

public extension UIColor {
    convenience init(_ rgb: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((rgb >> 16) & 0xff) / 255.0,
            green: CGFloat((rgb >> 8) & 0xff) / 255.0,
            blue: CGFloat(rgb & 0xff) / 255.0,
            alpha: alpha)
    }
}

public extension UILabel {
    convenience init(text: String? = nil,
        textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil, font: UIFont? = nil,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UILabel) -> Void)? = nil) {
        self.init()

        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UIImageView {
    convenience init(image: UIImage? = nil,
        contentMode: UIControl.ContentMode = .scaleToFill,
        tintColor: UIColor? = nil,
        width: CGFloat = .nan, height: CGFloat = .nan,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIImageView) -> Void)? = nil) {
        self.init()

        self.image = image
        self.contentMode = contentMode
        self.tintColor = tintColor

        self.lm_width = width
        self.lm_height = height
        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

private struct AssociatedKeys {
    static var actionKey = "actionKey"
}

typealias BtnAction = (UIButton) -> Void

public extension UIButton {
    
    private var action: BtnAction? {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? BtnAction
        }
    }
    
    @objc func buttonClicked(_ btn: UIButton) {
        action?(btn)
    }
    
    convenience init(type: UIButton.ButtonType,
        title: String? = nil, image: UIImage? = nil,
        tintColor: UIColor? = nil,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        action: ((UIButton) -> Void)? = nil,
        with: ((UIButton) -> Void)? = nil) {
        self.init(type: type)

        setTitle(title, for: .normal)
        setImage(image, for: .normal)

        self.tintColor = tintColor

        self.weight = weight
        self.anchor = anchor
        
        self.addTarget(self, action:#selector(buttonClicked(_:)) , for:.touchUpInside)
        self.action = action

        with?(self)
    }
}

typealias TextFieldAction = (UITextField) -> Void

public extension UITextField {
    
    private var editChange: TextFieldAction? {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? TextFieldAction
        }
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        editChange?(sender)
    }
    
    convenience init(placeholder: String? = nil,
        textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil, font: UIFont? = nil,
        borderStyle: UITextField.BorderStyle = .none,
        keyboardType: UIKeyboardType = .default,
        autocorrectionType: UITextAutocorrectionType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .sentences,
        isSecureTextEntry: Bool = false,
        width: CGFloat = .nan,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        editChange: ((UITextField) -> Void)? = nil,
        with: ((UITextField) -> Void)? = nil) {
        self.init()

        self.placeholder = placeholder
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
        self.borderStyle = borderStyle
        self.keyboardType = keyboardType
        self.autocorrectionType = autocorrectionType
        self.autocapitalizationType = autocapitalizationType
        self.isSecureTextEntry = isSecureTextEntry

        self.lm_width = width
        self.weight = weight
        self.anchor = anchor
        
        self.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        self.editChange = editChange

        with?(self)
    }
}

#if os(iOS)
public extension UIDatePicker {
    convenience init(datePickerMode: UIDatePicker.Mode = .dateAndTime,
        height: CGFloat = .nan,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIDatePicker) -> Void)? = nil) {
        self.init()

        self.datePickerMode = datePickerMode

        self.lm_height = height
        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UISwitch {
    convenience init(tintColor: UIColor? = nil,
        onTintColor: UIColor? = nil,
        with: ((UISwitch) -> Void)? = nil) {
        self.init()

        self.tintColor = tintColor
        self.onTintColor = onTintColor

        with?(self)
    }
}
#endif

public extension UISegmentedControl {
    convenience init(tintColor: UIColor? = nil,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UISegmentedControl) -> Void)? = nil) {
        self.init()

        self.tintColor = tintColor

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

#if os(iOS)
public extension UISlider {
    convenience init(minimumValue: Float = 0.0, maximumValue: Float = 1.0,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UISlider) -> Void)? = nil) {
        self.init()

        self.minimumValue = minimumValue
        self.maximumValue = maximumValue

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UIStepper {
    convenience init(minimumValue: Double = 0.0, maximumValue: Double = 100.0,
        stepValue: Double = 1.0,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIStepper) -> Void)? = nil) {
        self.init()

        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.stepValue = stepValue

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}
#endif

public extension UIPageControl {
    convenience init(pageIndicatorTintColor: UIColor? = nil,
        currentPageIndicatorTintColor: UIColor? = nil,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIPageControl) -> Void)? = nil) {
        self.init()

        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UIActivityIndicatorView {
    convenience init(style: UIActivityIndicatorView.Style,
        color: UIColor? = nil,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIActivityIndicatorView) -> Void)? = nil) {
        self.init(style: style)

        self.color = color

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UIProgressView {
    convenience init(progressTintColor: UIColor? = nil,
        trackTintColor: UIColor? = nil,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UIProgressView) -> Void)? = nil) {
        self.init()

        self.progressTintColor = progressTintColor
        self.trackTintColor = trackTintColor

        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UITextView {
    convenience init(textContainer: NSTextContainer? = nil,
        isEditable: Bool = true, isSelectable: Bool = true,
        textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil, font: UIFont? = nil,
        width: CGFloat = .nan, height: CGFloat = .nan,
        weight: CGFloat = .nan,
        anchor: LMAnchor = [],
        with: ((UITextView) -> Void)? = nil) {
        self.init(frame: CGRect(), textContainer: textContainer)

        #if os(iOS)
        self.isEditable = isEditable
        #endif
        
        self.isSelectable = isSelectable
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font

        self.lm_width = width
        self.lm_height = height
        self.weight = weight
        self.anchor = anchor

        with?(self)
    }
}

public extension UITableViewCell {
    convenience init(style: UITableViewCell.CellStyle,
        text: String? = nil, detailText: String? = nil,
        accessoryType: UITableViewCell.AccessoryType = .none,
        selectionStyle: UITableViewCell.SelectionStyle = .blue,
        with: ((UITableViewCell) -> Void)? = nil) {
        self.init(style: style, reuseIdentifier: nil)

        textLabel?.text = text
        detailTextLabel?.text = detailText

        self.accessoryType = accessoryType
        self.selectionStyle = selectionStyle

        with?(self)
    }
}

public extension UITableViewHeaderFooterView {
    convenience init(text: String? = nil, detailText: String? = nil,
        with: ((UITableViewHeaderFooterView) -> Void)? = nil) {
        self.init()

        textLabel?.text = text
        detailTextLabel?.text = text

        with?(self)
    }
}
