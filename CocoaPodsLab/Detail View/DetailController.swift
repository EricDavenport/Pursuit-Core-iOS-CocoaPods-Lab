//
//  DetailController.swift
//  CocoaPodsLab
//
//  Created by Eric Davenport on 3/6/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import ImageKit

class DetailController: UIViewController {
  
  let detailView = DetailView()
  
  var user : User?
  
  override func loadView() {
    view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  init(_ user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder: ) has not been implemented.")
  }
  
  func updateUI() {
    guard let user = user else { return }
    detailView.addressLabel.text = user.location.fullAddress()
    detailView.dobLabel.text = user.dob.date
    detailView.phoneLabel.text = "Cell: \(user.cell)/nHome: \(user.phone)"
    detailView.imageView.getImage(with: user.picture.large) { [weak self] (result) in
      switch result {
      case .failure(let appError):
        print("error: \(appError)")
      case .success(let image):
        DispatchQueue.main.async {
          self?.detailView.imageView.image = image
        }
      }
    }
  }
  
  
  
  
}
