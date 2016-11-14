/*
 
 The MIT License (MIT)
 
 Copyright (c) 2015 Cereopsis
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

class ViewController: UICollectionViewController {

    var itemsPerSection = 4
    var datasource: [Int] = [1,2,3,4,5,6,7,8,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource.count / itemsPerSection + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section + 1) * itemsPerSection > datasource.count {
            return datasource.count % itemsPerSection
        }
        return itemsPerSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.label.text = "\(indexPath.section), \(indexPath.item)"
        return cell
    }
    
    @IBAction func goSmall(_ sender: AnyObject) {
        let collection = collectionView!
        collection.performBatchUpdates({
            collection.deleteSections(IndexSet(integer: 2))
            collection.deleteItems(at: IndexPath.indexPaths(inSection: 1, range: 1..<4))
            self.datasource = [1,2,3,4,5]
            }, completion: nil)
    }
 
    @IBAction func goLarge(_ sender: AnyObject) {
        let collection = collectionView!
        collection.performBatchUpdates({
            collection.insertSections(IndexSet(integer: 3))
            collection.insertItems(at: IndexPath.indexPaths(inSection: 2, range: 1..<4))
            self.datasource = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
            }, completion: nil)
    }
    
    @IBAction func reload(_ sender: AnyObject) {
        datasource = [1,2,3,4,5,6,7,8,9]
        collectionView!.reloadData()
    }
}

extension IndexPath {
    
    /// Returns an array of index paths where `item` is contained in `range` and section == `section`
    static func indexPaths(inSection section: Int, range: CountableRange<Int>) -> [IndexPath] {
        return range.map { i in IndexPath(item: i, section: section) }
    }
    
}


class Cell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}
