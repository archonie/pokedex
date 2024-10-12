//
//  PokedexController.swift
//  PokedexApp
//
//  Created by Doğan Ensar Papuçcuoğlu on 12.10.2024.
//

import UIKit

private let reuseIdentifier = "PokedexCell"

class PokedexController: UICollectionViewController {
    
    //MARK: - Properties
    
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    
    //MARK: - Selectors
    
    @objc func showSearchBar() {
        print("123")
    }
    
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        collectionView.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mainPink()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false 
        
        navigationItem.title = "Pokedex"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}


extension PokedexController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokedexCell
        cell.backgroundColor = .blue
        return cell
    }

}

//MARK: - CollectionViewDelegetaFlowLayout

extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
        
    }
}

