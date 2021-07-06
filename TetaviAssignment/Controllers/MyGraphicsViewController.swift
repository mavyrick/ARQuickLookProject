//
//  MyGraphicsViewController.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 03/07/2021.
//

import UIKit
import QuickLook

class MyGraphicsViewController: UIViewController {

    @IBOutlet weak var myGraphicsCollectionView: UICollectionView!

    var myGraphicsItems: [MyGraphicsItem] = []
    
    let updateMyGraphicsService: UpdateMyGraphicsServiceProtocol = FirebaseUpdateMyGraphicsService()
    
    var modelIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        myGraphicsCollectionView.delegate = self
        myGraphicsCollectionView.dataSource = self
        
        myGraphicsCollectionView.backgroundColor = .systemGray6
                
        updateMyGraphics()
        
    }
    
    func updateMyGraphics() {
        updateMyGraphicsService.updateMyGraphicsData(completion: { (myGraphicsItems, error) -> Void in
            self.myGraphicsItems = myGraphicsItems
            DispatchQueue.main.async {
                self.myGraphicsCollectionView.reloadData()
            }
        })
    }
    
    func presentQuickLookPreview(indexPath: IndexPath) {
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        quickLookViewController.delegate = self
        quickLookViewController.currentPreviewItemIndex = indexPath.row
        present(quickLookViewController, animated: true)
    }

}

extension MyGraphicsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myGraphicsItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphicCell", for: indexPath as IndexPath) as! MyGraphicsCollectionViewCell
                
        cell.myGraphicsItem = myGraphicsItems[indexPath.row]
                
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        modelIndex = indexPath.row
        myGraphicsCollectionView.deselectItem(at: indexPath, animated: true)
        
        self.presentQuickLookPreview(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width: CGFloat

            width = (collectionView.frame.width / 2) - 1
        
        return CGSize(width: width, height: width)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension MyGraphicsViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            
            guard let path = Bundle.main.path(forResource: myGraphicsItems[modelIndex!].modelName, ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
                    let url = URL(fileURLWithPath: path)
                    return url as QLPreviewItem
        }
    
    func previewController(_ controller: QLPreviewController, transitionImageFor item: QLPreviewItem, contentRect: UnsafeMutablePointer<CGRect>) -> UIImage? {
                    
        return UIImage()
    }
}
