import UIKit
import CoreData

class AvailableCarsViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var availableCars: [Vehiculo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear vehículos por defecto si es necesario
        CoreDataManager.shared.createDefaultVehiclesIfNeeded()
        
        // Cargar vehículos disponibles
        loadAvailableCars()
        
        collectionView.dataSource = self
    }
    
    func loadAvailableCars() {
        let fetchRequest: NSFetchRequest<Vehiculo> = Vehiculo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "disponibilidad == %@", NSNumber(value: false))
        
        do {
            availableCars = try CoreDataManager.shared.context.fetch(fetchRequest)
            collectionView.reloadData()
        } catch {
            print("Error al cargar vehículos disponibles: \(error)")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableCars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as! CarCollectionViewCell
        let car = availableCars[indexPath.item]
        cell.configure(with: car)
        return cell
    }
}
