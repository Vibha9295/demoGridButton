//
//  ViewController.swift
//  demoGridButtons
//
//  Created by vibha on 03/10/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var arrCount = NSMutableArray()
    var  SqrRoot = Double()
    var indexPath1 = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = false
        
        DispatchQueue.main.async {
            self.showAlertGame()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func showAlertGame()  {
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Number"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            textField?.keyboardType = .numberPad
            
            self.SqrRoot = (NSString(string:(textField?.text)!).doubleValue).squareRoot()
            
            for i in 1...Int( NSString(string:((textField?.text)!)).doubleValue) {
                self.arrCount.add(i)
            }
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        
        //        for i in 0...self.arrCount.count{
        //            let result = pow(Decimal(i), 2)
        //
        //            print("\(i) squared = \(result)")
        //
        //        }
        if indexPath.row == Int(self.SqrRoot){
            cell.lblColection.backgroundColor = UIColor.cyan
        }else if indexPath == indexPath1{
            cell.lblColection.backgroundColor = UIColor.clear
        }else{
            cell.lblColection.backgroundColor = UIColor.gray
        }
        
        
        cell.lblColection.text = String(describing: arrCount[indexPath.row])
        
//        if indexPath == indexPath1{
//            cell.lblColection.backgroundColor = UIColor.clear
//        }else{
//            cell.lblColection.backgroundColor = UIColor.gray
//        }
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, CGFloat(self.SqrRoot) - 1)*horizontalSpacing)/CGFloat(self.SqrRoot)
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
         
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.lblColection.backgroundColor = UIColor.cyan
        
        //if cell.lblColection.backgroundColor != UIColor.white{
            indexPath1 = IndexPath(item: Int(arc4random_uniform(UInt32(self.arrCount.count))), section: 0)
            
            collectionView.reloadItems(at: [indexPath1])
        //}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
       cell.lblColection.backgroundColor = UIColor.gray
        //if indexPath == indexPath1{
            let alertController = UIAlertController(
                title: "Congratulations!", message: "You won the game", preferredStyle: .alert)
            let defaultAction = UIAlertAction(
                title: "Close", style: .default, handler: nil)
            //you can add custom actions as well
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        //}
    }
}
