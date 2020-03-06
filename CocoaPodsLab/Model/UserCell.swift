//
//  UserCell.swift
//  CocoaPodsLab
//
//  Created by Eric Davenport on 3/6/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout
import ImageKit

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0


class UserCell: CollectionViewSlantedCell {
    
  
  @IBOutlet weak var userImageView: UIImageView!
  
  @IBOutlet weak var emailLabel: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  public func configureCell(with user: User) {
    emailLabel.text = user.email
    nameLabel.text = user.name.fullName()
    userImageView.getImage(with: user.picture.medium) { [weak self] (result) in
      switch result {
      case .failure(let error):
        print("unable to load photo: \(error.localizedDescription)")
      case.success(let image):
        DispatchQueue.main.async {
                  self?.userImageView.image = image
        }
      }
    }
  }
  
  var imageHeight: CGFloat {
      return (userImageView?.image?.size.height) ?? 0.0
  }

  var imageWidth: CGFloat {
      return (userImageView?.image?.size.width) ?? 0.0
  }

  func offset(_ offset: CGPoint) {
      userImageView.frame = userImageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
  }
  
  
}
