//
//  FavoritesTableViewController.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/3/25.
//

import UIKit
class FavoritesTableViewController: MavelTableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mis Favoritos"
        

        loadFavorites()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MarvelTableViewCell
        
        let favorite = favoriteItems[indexPath.row]
        
        cell.nameTxt?.text = favorite.name
        cell.idTxt?.text = favorite.id
        cell.ImageView.loadImageRemote(url: URL(string: favorite.photo!)!)
        
        // Muestra el ícono de favorito
        cell.accessoryView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        return cell
    }
    
    // MARK: - Context Menu
    
    // Sobreescribe el menú para que solo ofrezca la opción de eliminar
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let favoriteItem = favoriteItems[indexPath.row]
        
        let removeFavoriteAction = UIAction(title: "Eliminar de favoritos", image: UIImage(systemName: "heart.slash.fill"), attributes: .destructive) { _ in
            self.removeFromFavorites(id: favoriteItem.id!)
            tableView.reloadData() 
        }
        
        let menu = UIMenu(title: "", children: [removeFavoriteAction])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return menu
        }
    }
}
