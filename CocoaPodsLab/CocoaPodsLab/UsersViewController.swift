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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? CollectionViewSlantedCell else {
      fatalError("Unable to downcast cell to CollectionViewSlantedCell")
    }
    let user = users[indexPath.row]
    
    if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
      cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
    }
//    cell.imageView = UIImage(
    cell.backgroundColor = .orange
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
}

extension UsersViewController : UICollectionViewDelegate {
  
}

//
//
//extension ViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return covers.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//                            as? CustomCollectionCell else {
//            fatalError()
//        }
//
//        cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!
//
//        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
//            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
//        }
//
//        return cell
//    }
//}
//
//extension ViewController: CollectionViewDelegateSlantedLayout {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: CollectionViewSlantedLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
//        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
//    }
//}
//
//extension ViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let collectionView = collectionView else {return}
//        guard let visibleCells = collectionView.visibleCells as? [CustomCollectionCell] else {return}
//        for parallaxCell in visibleCells {
//            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
//            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
//            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
//        }
//    }
//}
