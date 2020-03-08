//
//  ViewController.swift
//  CocoaPodsLab
//
//  Created by Eric Davenport on 3/6/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class UsersViewController: UIViewController {
  
  let viewLayout = CollectionViewSlantedLayout()
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var users = [User]() {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewLayout.isFirstCellExcluded = true
    viewLayout.isLastCellExcluded = true
    viewLayout.lineSpacing = 5
    viewLayout.slantingDirection = .downward
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionViewSetup()
    loadUsers()
  }
  
  private func collectionViewSetup() {
    collectionView.collectionViewLayout = viewLayout
    
  }
  
  private func loadUsers() {
    APIClient.fetchUser { (result) in
      switch result {
      case .failure(let error):
        print("No users loaded \(error)")
      case .success(let user):
        self.users = user
        print(self.users.count)
      }
    }
  }
  
}

extension UsersViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCell else {
      fatalError("Unable to downcast cell to CollectionViewSlantedCell")
    }
    let user = users[indexPath.row]
    
    if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
      cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
    }
    
    cell.configureCell(with: user)
    cell.backgroundColor = .systemGroupedBackground
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
}

//extension UsersViewController : UICollectionViewDelegate {
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    print("Selected row \(indexPath.row)/nUser: \(users[indexPath.row].name.fullName())")
//  }
//}


extension UsersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [UserCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}



extension UsersViewController: CollectionViewDelegateSlantedLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
      print("Selected row \(indexPath.row)/nUser: \(users[indexPath.row].name.fullName())")

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}
