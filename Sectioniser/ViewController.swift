//
//  ViewController.swift
//  Sectioniser
//
//  Created by John Walker on 22/09/2016.
//  Copyright © 2016 John Walker. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var itemsPerSection = 4
    var datasource: [Int] = [1,2,3,4,5,6,7,8,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return datasource.count / itemsPerSection + 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section + 1) * itemsPerSection > datasource.count {
            return datasource.count % itemsPerSection
        }
        return itemsPerSection
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        cell.label.text = "\(indexPath.section), \(indexPath.item)"
        return cell
    }
    
    @IBAction func goSmall(sender: AnyObject) {
        let collection = collectionView!
        collection.performBatchUpdates({
            collection.deleteSections(NSIndexSet(index: 2))
            collection.deleteItemsAtIndexPaths(NSIndexPath.indexPaths(inSection: 1, range: 1..<4))
            self.datasource = [1,2,3,4,5]
            }, completion: nil)
    }
 
    @IBAction func goLarge(sender: AnyObject) {
        let collection = collectionView!
        collection.performBatchUpdates({
            collection.insertSections(NSIndexSet(index: 3))
            collection.insertItemsAtIndexPaths(NSIndexPath.indexPaths(inSection: 2, range: 1..<4))
            self.datasource = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
            }, completion: nil)
    }
    
    @IBAction func reload(sender: AnyObject) {
        datasource = [1,2,3,4,5,6,7,8,9]
        collectionView!.reloadData()
    }
}

extension NSIndexPath {
    
    /// Returns an array of index paths where `item` is contained in `range` and section == `section`
    static func indexPaths(inSection section: Int, range: Range<Int>) -> [NSIndexPath] {
        return range.map { i in NSIndexPath(forItem: i, inSection: section) }
    }
    
}


class Cell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}