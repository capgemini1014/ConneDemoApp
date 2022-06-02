//
//  ViewController.swift
//  ConneappDemo
//
//  Created by Santanu on 28/05/2022.
//

import UIKit

class HomeViewController: UIViewController,APIResponseDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    let flowLayout = ZoomAndSnapFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collection.dataSource = self
        collection.collectionViewLayout = flowLayout
        collection.contentInsetAdjustmentBehavior = .always
        collection.register(WeatherCellView.self, forCellWithReuseIdentifier: Identifier.Cell)
        
        
        initViewModel()
    }
    func initViewModel() {
        viewModel.delegate = self
        viewModel.initFetch()
    }
    func completedApiRequest() {
        DispatchQueue.main.async {
            self.collection?.reloadData()
            self.loadTableView(collectionRow: 0)
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        viewModel.isOnline = sender.isOn ? true : false
        viewModel.initFetch()
    }
    func showError() {
        if let message = self.viewModel.alertMessage {
            self.showAlert( message )
        }
    }
    func statusAPIRequest() {
        DispatchQueue.main.async {
            let isLoading = self.viewModel.isLoading
            if isLoading {
                self.loadingIndicator?.startAnimating()
            }else {
                self.loadingIndicator?.stopAnimating()
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.collection?.alpha = self.viewModel.returnAlpha()
            })
            
        }
    }
    
    private func showAlert( _ message: String ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Strings.alertTitle, message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: Strings.Ok, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension HomeViewController  { 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell, for: indexPath) as! WeatherCellView
        cell.index = indexPath.row
        viewModel.populatedTableData(num: indexPath.row)
        cell.design(items: viewModel.filterWeatherData)
        return cell
    }
    
    func loadTableView(collectionRow: Int) {
        viewModel.populatedTableData(num: collectionRow)
        collection.reloadData()
    }
}

