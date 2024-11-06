import UIKit

class AdditionalInfoViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // Diccionario que contiene los datos de `RegisterViewController`
    var userData: [String: Any]?

    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        // Agrega `Email` y `Contraseña` a `userData`
        userData?["clientEmail"] = emailTextField.text
        userData?["clientPassword"] = passwordTextField.text

        // Llama a la función para crear el cliente en Core Data
        createClient()
    }

    func createClient() {
        guard let data = userData else { return }
        
        let context = CoreDataManager.shared.context
        let client = Cliente(context: context)
        
        // Asigna los valores al objeto `Cliente`
        client.clientId = UUID()
        client.clientName = data["clientName"] as? String
        client.clientDni = data["clientDni"] as? String
        client.clientTelefono = data["clientTelefono"] as? String
        client.clientFechaNac = data["clientFechaNac"] as? Date
        client.clientEmail = data["clientEmail"] as? String
        client.clientPassword = data["clientPassword"] as? String
        
        // Guarda el contexto
        CoreDataManager.shared.saveContext()
        print("Usuario creado exitosamente")
        // Imprime todos los usuarios en la consola después de crear uno
        CoreDataManager.shared.printAllUsers()

        // Agrega una alerta y redirige a LoginViewController
        let alert = UIAlertController(title: "Cuenta Creada", message: "El usuario ha sido creado exitosamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Redirigir a LoginViewController
            self.navigateToLogin()
        })
        present(alert, animated: true, completion: nil)
    }

    func navigateToLogin() {
        // Supone que LoginViewController está en el storyboard principal
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            // Cambia la vista actual a LoginViewController
            navigationController?.setViewControllers([loginVC], animated: true)
        }
    }
}
