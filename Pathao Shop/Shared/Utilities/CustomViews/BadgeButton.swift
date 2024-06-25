//
//  BadgeButton.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//

import UIKit

class BadgeButton: UIButton {
  
  // MARK: - Properties
  
  let defaultRedBadgeBG = UIColor(red: 0.733, green: 0.208, blue: 0.392, alpha: 1)
  let defaultCornerRadius: CGFloat = 5
  let defaultFontSize: CGFloat = 10
  let defaultBadgeSize = CGSize(width: 17, height: 17)
  
  /// Reference to prevent blinking animation
  private(set) var currentBadgeCount: Int = 0
  
  private lazy var badgeBGView: UIView = {
    let v = UIView()
    v.backgroundColor = defaultRedBadgeBG
    v.layer.cornerRadius = defaultCornerRadius
    v.translatesAutoresizingMaskIntoConstraints = false
    v.alpha = 0
    v.addSubview(badgeCountLabel)
    NSLayoutConstraint.activate([
      badgeCountLabel.topAnchor.constraint(equalTo: v.topAnchor),
      badgeCountLabel.bottomAnchor.constraint(equalTo: v.bottomAnchor),
      badgeCountLabel.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 4),
      badgeCountLabel.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -4)
    ])
    return v
  }()
  
  private lazy var badgeCountLabel: UILabel = {
    let label = UILabel()
      label.textColor = .white
      label.textAlignment = .center
      label.font = .systemFont(ofSize: defaultFontSize)
      label.layer.cornerRadius = defaultCornerRadius
      label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var icon: UIImage!
  
  // MARK: - Functions
  // MARK: Overrides
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         // Perform any additional setup if needed
         layout()
     }
    

  
  private func layout() {
    setImage(
      icon,
      for: .normal
    )
    
    addSubview(badgeBGView)
    NSLayoutConstraint.activate([
      badgeBGView.heightAnchor.constraint(equalToConstant: defaultBadgeSize.height),
      badgeBGView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      badgeBGView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    ])
  }
  

}

// MARK: - Public

@objc
extension BadgeButton {
  func setBadgeValue(_ value: Int) {
    guard currentBadgeCount != value else {
      return
    }
    currentBadgeCount = value
    
    DispatchQueue.main.async {
      if self.badgeBGView.alpha == 0 {
        UIView.animate(withDuration: 0.3) {
          self.badgeBGView.alpha = 1
        }
      }
      
      guard value > 0 else {
        self.removeBadge()
        return
      }
     
      UIView.transition(with: self.badgeCountLabel,
                        duration: 0.3,
                        options: .transitionFlipFromBottom,
                        animations: {
        let text: String =  "\(value)"
        self.badgeCountLabel.text = text
      }, completion: nil)
    }
  }
  
  /// Remove the badge.
  func removeBadge() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3,
                     delay: 0,
                     options: .curveEaseOut) {
        self.badgeBGView.alpha = 0
        self.badgeCountLabel.text = ""
      }
    }
  }
}
