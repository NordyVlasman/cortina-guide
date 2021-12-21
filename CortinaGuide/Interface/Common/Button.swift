//
//  Button.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import UIKit

class CortinaButton: UIButton {
    
    enum ButtonType {
        case roundedBlue
        case roundedWhite
        case roundedBlueBorder
        case textLabelBlue
    
        func backgroundColor(isEnabled: Bool = true) -> UIColor {
            switch self {
            case .roundedBlue:
                return isEnabled ? .blue : .gray
            case .roundedWhite, .roundedBlueBorder:
                return isEnabled ? .white : .gray
            case .textLabelBlue:
                return .clear
            }
        }
        
        func textColor(isEnabled: Bool = true) -> UIColor {
            switch self {
            case .roundedBlue:
                return isEnabled ? .white : .lightGray
            case .roundedWhite, .roundedBlueBorder:
                return isEnabled ? .blue : .lightGray
            case .textLabelBlue:
                return isEnabled ? .blue : .lightGray
            }
        }
        
        var contentEdgeInsets: UIEdgeInsets {
            switch self {
            case .textLabelBlue: return .zero
            default: return .topBottom(15) + .leftRight(56)
            }
        }
        
        func borderColor(isEnabled: Bool = true) -> UIColor {
            switch self {
            case .roundedBlueBorder:
                return isEnabled ? .blue : .gray
            default:
                return isEnabled ? .clear : .gray
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .roundedBlueBorder: return 1
            default: return 0
            }
        }
        
        var isRounded: Bool {
            switch self {
            case .textLabelBlue: return false
            default: return true
            }
        }
    }
    
    var style = ButtonType.roundedBlue {
        didSet {
            setupButtonType()
        }
    }
    
    var title: String? = "" {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            setupColors()
        }
    }
    
    var useHapticFeedback = true
    
    required init(title: String = "", style: ButtonType = .roundedBlue) {
        super.init(frame: .zero)
        
        defer {
            self.title = title
            self.style = style
        }
        
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.numberOfLines = 0
        
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(self.touchUpAnimation), for: [.touchDragExit, .touchCancel, .touchUpInside])
        self.addTarget(self, action: #selector(self.touchDownAnimation), for: .touchDown)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func touchUpInside(_ target: Any?, action: Selector) -> Self {
        super.addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = style.isRounded ? min(bounds.width, bounds.height) / 2 : 0
        titleLabel?.preferredMaxLayoutWidth = titleLabel?.frame.size.width ?? 0
    }
    
    // MARK: - Private
    
    private func setupButtonType() {
        setupColors()
        
        layer.borderWidth = style.borderWidth
        
        setNeedsLayout()
    }
    
    private func setupColors() {
        backgroundColor = style.backgroundColor(isEnabled: isEnabled)
        setTitleColor(style.textColor(isEnabled: true), for: .normal)
        setTitleColor(style.textColor(isEnabled: false), for: .disabled)
        layer.borderColor = style.borderColor(isEnabled: isEnabled).cgColor
    }
    
    @objc private func touchDownAnimation() {
        if useHapticFeedback { Haptic.light() }
        
        UIButton.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        })
    }
    
    @objc private func touchUpAnimation() {
        UIButton.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
