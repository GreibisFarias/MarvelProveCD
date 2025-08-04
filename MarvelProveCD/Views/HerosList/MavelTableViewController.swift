//
//  MavelTableViewController.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/1/25.
//

import UIKit
import Combine
import CoreData

struct heroes: Identifiable{
    let id: String
    let name: String
    let photo: String
}


let hero = [heroes(id: "10", name: "Holi", photo: "https://preview.redd.it/6qmh2t19hb461.png?width=1080&crop=smart&auto=webp&s=fc59913597a0c7882631a525e768fab863f0eaa4"),
            heroes(id: "11", name: "Shino", photo: "https://static.wikia.nocookie.net/naruto/images/b/bb/Shino_Aburame_Parte_I_Anime.png/revision/latest/scale-to-width/360?cb=20140418005612&path-prefix=es"),
            heroes(id: "12", name: "Shavo", photo: "https://static.wikia.nocookie.net/fairytaillatino/images/2/2b/Gray_in_Tartaros_arc.png/revision/latest?cb=20160527231715&path-prefix=es")]


class MavelTableViewController: UITableViewController {
    private var ms = MarvelViewModel()
    private var managedObjectContext: NSManagedObjectContext!
    private var cancellables = Set<AnyCancellable>()
    var favoriteItems = [Favoritos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Carga los favoritos al inicio para tener la lista actualizada
        loadFavorites()
        
        tableView.register(UINib(nibName: "MarvelTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        ms.fetchPersonas()
        
        ms.$Characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let favoritesImage = UIImage(systemName: "heart.fill")
        
        // 2. Crea el botón de barra con la imagen
        let favoritesButton = UIBarButtonItem(image: favoritesImage, style: .plain, target: self, action: #selector(showFavorites))
        
        // 3. Asigna el botón a la esquina superior derecha
        self.navigationItem.rightBarButtonItem = favoritesButton
        
    }
    
    
    @objc func showFavorites() {
        let newTransformationVC = FavoritesTableViewController() // Asegúrate de instanciar tu vista
        self.navigationController?.show(newTransformationVC, sender: nil)
    }
    
    // Función para cargar los favoritos desde Core Data
    func loadFavorites() {
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        
        do {
            favoriteItems = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error al cargar favoritos: \(error.localizedDescription)")
        }
    }
    
    // Función para verificar si un item es favorito
    func isFavorite(id: String) -> Bool {
        return favoriteItems.contains { $0.id == id }
    }
    
    func addToFavorites(id: String, name: String, photo: String) {
        if !isFavorite(id: id) {
            let newFavorite = Favoritos(context: managedObjectContext) // Nota: Usas Favoritos, no Favorite
            newFavorite.id = id
            newFavorite.name = name
            newFavorite.photo = photo
            
            do {
                try managedObjectContext.save()
                print("Agregado a favoritos: \(name)")
                loadFavorites()
            } catch {
                print("Error al guardar favorito: \(error.localizedDescription)")
            }
        }
    }
    
    func removeFromFavorites(id: String) {
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        
        // El predicate busca el objeto Favoritos que tenga el mismo id que le pasamos.
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            // Si se encuentra al menos un objeto con ese ID
            if let favoriteToDelete = results.first {
                // Se elimina del contexto
                managedObjectContext.delete(favoriteToDelete)
                // Se guardan los cambios en Core Data
                try managedObjectContext.save()
                print("Eliminado de favoritos: ID \(id)")
                
                // Recargamos la lista de favoritos para actualizar la vista.
                loadFavorites()
            }
        } catch {
            print("Error al eliminar favorito: \(error.localizedDescription)")
        }
    }
//    
//    func anotherProfile(){
//        if 
//        
//    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hero.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MarvelTableViewCell
        //        let chac = ms.Characters[indexPath.row]
        let mock = hero[indexPath.row]
        let onichan = mock.id.count
        let onichan2 = String(onichan)
        
        cell.nameTxt?.text = mock.name
        cell.idTxt?.text = onichan2
        cell.ImageView.loadImageRemote(url: URL(string: mock.photo)!)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let heroItem = hero[indexPath.row]
        let isItemFavorite = isFavorite(id: heroItem.id)
        
        // Acción para agregar a favoritos
        let addFavoriteAction = UIAction(title: "Agregar a favoritos", image: UIImage(systemName: "heart.fill")) { _ in
            // ¡Aquí está la llamada correcta!
            self.addToFavorites(id: heroItem.id, name: heroItem.name, photo: heroItem.photo)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let removeFavoriteAction = UIAction(title: "Eliminar de favoritos", image: UIImage(systemName: "heart.slash.fill"), attributes: .destructive) { _ in
            self.removeFromFavorites(id: heroItem.id)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let menu = UIMenu(title: "", children: isItemFavorite ? [removeFavoriteAction] : [addFavoriteAction])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return menu
        }
    }
}

