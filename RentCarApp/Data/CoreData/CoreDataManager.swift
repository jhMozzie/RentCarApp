import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error al cargar el almacén de Core Data: \(error), \(error.userInfo)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar el contexto: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func printAllUsers() {
        let fetchRequest: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                print("Usuario:")
                print("Nombre: \(user.clientName ?? "Sin nombre")")
                print("Email: \(user.clientEmail ?? "Sin email")")
                print("Teléfono: \(user.clientTelefono ?? "Sin teléfono")")
                print("Fecha de nacimiento: \(user.clientFechaNac?.description ?? "Sin fecha")")
                print("-------------------------")
            }
        } catch {
            print("Error al obtener usuarios: \(error)")
        }
    }
    
    // Función para verificar si el email y la contraseña son correctos
       func isUserValid(email: String, password: String) -> Bool {
           let fetchRequest: NSFetchRequest<Cliente> = Cliente.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "clientEmail == %@ AND clientPassword == %@", email, password)
           
           do {
               let users = try context.fetch(fetchRequest)
               return !users.isEmpty
           } catch {
               print("Error al verificar el usuario: \(error)")
               return false
           }
       }
    
    func createDefaultVehiclesIfNeeded() {
            let fetchRequest: NSFetchRequest<Vehiculo> = Vehiculo.fetchRequest()
            
            do {
                let count = try context.count(for: fetchRequest)
                if count == 0 {
                    // Crear vehículos por defecto solo si no existen
                    let vehicle1 = Vehiculo(context: context)
                    vehicle1.marca = "Toyota"
                    vehicle1.modelo = "Corolla"
                    vehicle1.anio = 2024
                    vehicle1.precioPorDia = 150
                    vehicle1.disponibilidad = false // Disponible

                    let vehicle2 = Vehiculo(context: context)
                    vehicle2.marca = "Nissan"
                    vehicle2.modelo = "Sentra"
                    vehicle2.anio = 2023
                    vehicle2.precioPorDia = 130
                    vehicle2.disponibilidad = false // Disponible
                    
                    saveContext()
                }
            } catch {
                print("Error al verificar o crear vehículos por defecto: \(error)")
            }
    }
}
