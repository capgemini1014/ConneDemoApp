//
//  WeatherCellView.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//
import UIKit
class WeatherCellView: UICollectionViewCell, UITableViewDelegate,UITableViewDataSource  {
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var items = [WeatherListCellViewModel]()
    var index =  0
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func design(items: [WeatherListCellViewModel]) {
        self.items = items
        
        tableView.frame = CGRect(x:10, y: 15, width: 160, height: 320)
        self.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.tableCell)
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count //dataManager.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: Identifier.tableCell)
        cell.selectionStyle = .none
        //Image View
        let iConView = UIImageView()
        iConView.backgroundColor = .systemBlue
        iConView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        iConView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        let url = String(format: "%@%@@2x.png",WebAPI.iconUrl,items[indexPath.row].weatherIcon )
        iConView.downloadImageFromURL(url,icon: UIImage(named: "placeholder"))
        
        //Text Label
        let dateLabel = UILabel()
        dateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.numberOfLines = 0
        dateLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        dateLabel.text  = String(format: "Date:\n%@", self.items[indexPath.row].date)
        dateLabel.font = .systemFont(ofSize: 8)
        dateLabel.textAlignment = .left
        
        //Text Label
        let timeLabel = UILabel()
        timeLabel.numberOfLines = 0
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        timeLabel.text  = String(format: "Time:\n%@", self.items[indexPath.row].time)
        timeLabel.font = .systemFont(ofSize: 8)
        timeLabel.textAlignment = .left
        
        //Text Label
        let temperatureLabel = UILabel()
        temperatureLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        temperatureLabel.text  = String(format: "Temperature: %.1f", items[indexPath.row].temperature)
        temperatureLabel.font = .systemFont(ofSize: 8)
        temperatureLabel.textAlignment = .left
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 3
        
        let stackViewForDatetime   = UIStackView()
        stackViewForDatetime.axis  = NSLayoutConstraint.Axis.horizontal
        stackViewForDatetime.distribution  = UIStackView.Distribution.equalSpacing
        stackViewForDatetime.alignment = UIStackView.Alignment.center
        stackViewForDatetime.spacing   = 7
        stackViewForDatetime.addArrangedSubview(dateLabel)
        stackViewForDatetime.addArrangedSubview(timeLabel)
        
        let stackViewForDatetimeTemparature   = UIStackView()
        stackViewForDatetimeTemparature.axis  = NSLayoutConstraint.Axis.vertical
        stackViewForDatetimeTemparature.distribution  = UIStackView.Distribution.equalSpacing
        stackViewForDatetimeTemparature.alignment = UIStackView.Alignment.leading
        stackViewForDatetimeTemparature.spacing   = 0
        stackViewForDatetimeTemparature.addArrangedSubview(stackViewForDatetime)
        stackViewForDatetimeTemparature.addArrangedSubview(temperatureLabel)
        
        
        stackView.addArrangedSubview(iConView)
        stackView.addArrangedSubview(stackViewForDatetimeTemparature)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        return cell
    }
}



