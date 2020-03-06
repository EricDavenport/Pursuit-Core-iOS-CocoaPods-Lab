//
//  DetailView.swift
//  CocoaPodsLab
//
//  Created by Eric Davenport on 3/6/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import SnapKit
import ImageKit

class DetailView: UIView {

  public lazy var imageView : UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "photo.fill")
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  public lazy var addressLabel : UILabel = {
    let label = UILabel()
    label.text = "Address Label"
    return label
  }()
  
  public lazy var phoneLabel : UILabel = {
    let label = UILabel()
    label.text = "Phone Lsbel"
    return label
  }()
  
  public lazy var dobLabel : UILabel = {
    let label = UILabel()
    label.text = "dob label"
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imageViewConstraints()
    addresConstraints()
    phoneConstraints()
    dobConstraints()
  }


  private func imageViewConstraints() {
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.centerX.equalTo(self.snp.centerX)
      make.centerY.equalTo(self.snp.centerY)
      make.leading.trailing.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
    }
  }
  
  private func addresConstraints() {
    addSubview(addressLabel)
  }
  
  private func phoneConstraints() {
    addSubview(phoneLabel)
  }
  
  private func dobConstraints() {
    addSubview(dobLabel)
  }
  
  public func configureDetail() {
    
  }
}
