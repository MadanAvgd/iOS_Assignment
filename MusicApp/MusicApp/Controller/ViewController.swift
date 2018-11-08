//
//  ViewController.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var movieGridCollectionView: UICollectionView!
     var tuneDataSource:Tune?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let serviceLayer = ServiceLayer()
        serviceLayer.servcieRequest(urlString:GlobalConstants.kAppMusicSearchAPI) { (tune, errString) in
            if let errString = errString{
                let errorAlert  = UIAlertController(title: "Error!", message: errString, preferredStyle: UIAlertController.Style.alert)
                let action  = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { (action) in
                    errorAlert.dismiss(animated: true, completion: {
                        errorAlert.dismiss(animated: true, completion: nil)
                    })
                })
                errorAlert.addAction(action)
                self.present(errorAlert, animated: true, completion: nil)
            }
            
            if let tune = tune{
                self.tuneDataSource = tune as Tune?
            }
            DispatchQueue.main.async {
                self.movieGridCollectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let itemCount = self.tuneDataSource?.data?.count{
           // print(itemCount)
            return itemCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCollectionViewCellIdentifier = GlobalConstants.kSongsCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCellIdentifier, for: indexPath) as? SongsCollectionViewCell
        if cell != nil {
            
            if let obj =  tuneDataSource?.data?[indexPath.row]{
                cell?.movieTitle.text = obj.title!
                cell?.coverSmallImageView.image = UIImage(named: "defaultImage")
                let url = URL(string: obj.album!.coverSmall!)
                DispatchQueue.global().async {
                    if let url = url{
                        let data = try? Data(contentsOf: url)
                        if let data = data{
                            DispatchQueue.main.async {
                                cell?.coverSmallImageView.image = UIImage(data: data)
                            }
                        }
                    }else{
                        print("URL does not exists")
                    }
                }
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: GlobalConstants
            .kDetailsViewController, sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier? .isEqual (GlobalConstants.kDetailsViewController))!
        {
            print(sender!)
            let detailViewController = segue.destination as! DetailsViewController
            detailViewController.selectedIndex = sender as! Int
            detailViewController.tuneDataSource = self.tuneDataSource
        }
    }
}
