//
//  ViewController.swift
//  raktenRecipeAPI-Sample
//
//  Created by 木元健太郎 on 2022/01/03.
//

import UIKit

final class ItemsViewController: UIViewController {

  private let cellID = "UITableViewCell"
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    
  private var rakutenFoodItems: [RakutenFoodModel] = []
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
              tableView.delegate = self
              tableView.dataSource = self
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    API.shared.getCategory(success: {[weak self] (models) in
        self?.indicator.startAnimating()
            self?.rakutenFoodItems = models
            self?.tableView.reloadData()
        self?.indicator.isHidden = true
    }, error: nil)
  }
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        indicator.isHidden = false
        rakutenFoodItems = []
        switch sender.selectedSegmentIndex {
        case 0:
            API.shared.getCategory(success: {[weak self] (models) in
                self?.indicator.startAnimating()
                    self?.rakutenFoodItems = models
                    self?.tableView.reloadData()
                self?.indicator.isHidden = true
            }, error: nil)
        case 1:
            API.shared.getCategory(success: {[weak self] (models) in
                self?.indicator.startAnimating()
                let model = models.filter{$0.parentCategoryId == "39"}
                    self?.rakutenFoodItems = model
                    self?.tableView.reloadData()
                self?.indicator.isHidden = true
            }, error: nil)
        default:
            break
        }
    }
    
    
    
    
    
}

extension ItemsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let url = rakutenFoodItems[indexPath.row].url,
          UIApplication.shared.canOpenURL(url) else {
            return
          }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}

extension ItemsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rakutenFoodItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
      fatalError()
    }

    let item = rakutenFoodItems[indexPath.row]
      cell.textLabel?.text = item.categoryName

    return cell
  }
}

