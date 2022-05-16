//
//  TableViewCell.swift
//  InvoltaTestTask
//
//  Created by Vadim Voronkov on 06.05.2022.
//

import UIKit
import SnapKit

class MessageTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "TableViewCell"
    
    //MARK: - Views
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LabelColor")
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    public func configureTableViewCell(label: String) {
        self.messageLabel.text = label
    }
    
    private func setupLayout() {
        self.contentView.addSubview(messageLabel)
        self.messageLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(10)
            make.leading.trailing.equalTo(contentView).inset(10)
        }
    }
}
