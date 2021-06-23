//
//  ViewController.swift
//  CompositionLayoutExample
//
//  Created by Firat Tamur on 6/23/21.
//

import UIKit

fileprivate typealias ContactDataSource = UICollectionViewDiffableDataSource<CompositionLayoutViewController.Section, Contact>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<CompositionLayoutViewController.Section, Contact>

class CompositionLayoutViewController: UIViewController {
    
    let cellId = "cellId"
    private var contacts = [Contact]()
    private var dataSource: ContactDataSource!
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "CompositionLayout Example"
        
//        createData()
        configureHierarchy()
        configureDataSource()
        
    }
    
}

//MARK: - Collection view Setup
extension CompositionLayoutViewController {
    
    private func createData() {
        for i in 0..<10 {
            contacts.append(Contact(name: "Contact \(i)", image: ""))
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.25))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16,
                                                     bottom: 8, trailing: 16)
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    private func configureHierarchy() {
        
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        
    }
    
    private func configureDataSource() {
        
        dataSource = ContactDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, contact) -> ContactCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ContactCell
            cell.contact = contact
            return cell
            
        })
        
//        var snapshot = DataSourceSnapshot()
//        snapshot.appendSections([Section.main])
//        snapshot.appendItems(self.contacts)
//        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}


// MARK: - Collection view Delegate
extension CompositionLayoutViewController: UICollectionViewDelegate {
    
    fileprivate enum Section {
        case main
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let contact = dataSource.itemIdentifier(for: indexPath) else { return }
        print(contact)
    }
    
    
}
