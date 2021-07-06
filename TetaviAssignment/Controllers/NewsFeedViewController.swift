//
//  ViewController.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 01/07/2021.
//

import UIKit
import QuickLook
import Firebase

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var newsFeedItems: [NewsFeedItem] = []
    
    var myGraphicsIDs: [String] = []
    
    //    This class is completely decoupled and injectable except for these references which are interchangable.
    let updateNewsFeedService: UpdateNewsFeedServiceProtocol = FirebaseUpdateNewsFeedService()
    
    let updateMyGraphicsService: UpdateMyGraphicsServiceProtocol = FirebaseUpdateMyGraphicsService()
    
    let currentUser = Auth.auth().currentUser
    
    var modelIndex: Int?
    
    let newsFeedTableViewIdentifier = "newsFeedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        
        updateNewsFeed()
        
        updateMyGraphics()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavBarText()
    }
    
    func updateNewsFeed() {
        updateNewsFeedService.updateNewsFeedData(completion: { (newsFeedItems, error) -> Void in
            DispatchQueue.main.async {
                self.newsFeedItems = newsFeedItems
                self.newsFeedTableView.reloadData()
            }
            
        })
    }
    
    func updateMyGraphics() {
        updateMyGraphicsService.updateMyGraphicsData(completion: { (myGraphicsItems, error) -> Void in
            DispatchQueue.main.async {
                var idArray = myGraphicsItems.map({ (item: MyGraphicsItem) -> String in
                item.id
            })
            self.myGraphicsIDs = idArray
                self.newsFeedTableView.reloadData()
            }
        })
    }
    
    func setNavBarText() {
        if let displayName = currentUser?.displayName {
            self.tabBarController?.navigationItem.title = "Welcome \(displayName)!"
        }
    }
    
    func presentQuickLookPreview(indexPath: IndexPath) {
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        quickLookViewController.delegate = self
        quickLookViewController.currentPreviewItemIndex = indexPath.row
        present(quickLookViewController, animated: true)
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: newsFeedTableViewIdentifier, for: indexPath) as! NewsFeedTableViewCell
        
        cell.newsFeedItem = newsFeedItems[indexPath.row]
        
        print(newsFeedItems[indexPath.row].id)
        
        //        Temporary solution, will be costly with lots of data
        cell.downloaded = self.myGraphicsIDs.contains(where: { $0 == newsFeedItems[indexPath.row].id })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modelIndex = indexPath.row
        newsFeedTableView.deselectRow(at: indexPath, animated: true)
        
        self.presentQuickLookPreview(indexPath: indexPath)
    }
}

//I used these in the same way twice in my application which is something I would fix in the future
extension NewsFeedViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let path = Bundle.main.path(forResource: newsFeedItems[modelIndex!].modelName, ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
        let url = URL(fileURLWithPath: path)
        return url as QLPreviewItem
    }
    
    func previewController(_ controller: QLPreviewController, transitionImageFor item: QLPreviewItem, contentRect: UnsafeMutablePointer<CGRect>) -> UIImage? {
        
        return UIImage()
    }
    
}

