//
//  ExpandableView.swift
//  CustomDropdown
//
//  Created by Asraful Alam on 8/3/21.
//

import UIKit

@IBDesignable
class ExpandableView: UIView {
    
    private var tabdata = [String]()
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var headertitle: String? {
        didSet{
            self.titleLabel.text = headertitle
        }
    }
    
    public var data:[String]?{
        didSet{
            self.tabdata = data!
            self.tableView.reloadData()
        }
    }
    
    private var expandable: Bool = false {
        didSet{
            let image = expandable ? UIImage(named: "Expandable"): UIImage(named: "collapsible")
            self.expandableButton.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        constraints()
        setupTableView()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let expandableButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return button
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let tableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EzpandableViewCell.self, forCellReuseIdentifier: "EzpandableViewCell")
        return tableView
    }()
    
    func setupTableView() {
        
        self.expandable = false
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            
            self?.tableView.separatorStyle = .none
            self?.tableView.backgroundColor = .clear
        }
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUp(){
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(expandableButton)
        bottomStackView.addArrangedSubview(tableView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        addSubview(mainStackView)
    }
    
    func constraints() {
        setUp()
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        expandableButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        expandableButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    @objc func pressed(){
        self.expandable = !expandable
        tableView.isHidden = !tableView.isHidden
    }
}

extension ExpandableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EzpandableViewCell", for: indexPath) as! EzpandableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .clear
        cell.title = tabdata[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

final class DynamicHeightTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
