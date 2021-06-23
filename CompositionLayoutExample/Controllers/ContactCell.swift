//
//  ContactCell.swift
//  CompositionLayoutExample
//
//  Created by Firat Tamur on 6/23/21.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    var contact: Contact? {
        didSet {
            nameLabel.text = contact?.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCardCellShadow()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Contact Name", size: 22)
        label.textColor = UIColor.init(white: 0.3,
                                       alpha: 0.4)
        
        return label
        
    }()
    
    lazy var contactImage: UIImageView = {
        
        let profileImage = UIImage(systemName: "person.crop.circle")
        let renderedImage = profileImage!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: renderedImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private func setupCell() {
        
        self.backgroundView?.addSubview(contactImage)
        self.backgroundView?.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            contactImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contactImage.widthAnchor.constraint(equalToConstant: 50),
            contactImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 150),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    override var isHighlighted: Bool {
        
        didSet {
            
            var transform = CGAffineTransform.identity
            
            if isHighlighted {
                transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.transform = transform
            })
            
            
        }
        
    }
    
    func setupCardCellShadow() {
        
        backgroundView = UIView()
        addSubview(backgroundView!)
        
        backgroundView?.fillSuperview()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.cornerRadius = 26
        backgroundView?.layer.shadowOpacity = 0.1
        backgroundView?.layer.shadowOffset = .init(width: 4, height: 10)
        backgroundView?.layer.shadowRadius = 10
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.2
        layer.cornerRadius = 26
        
        self.layoutIfNeeded()
    
    }
    
}
