import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!

    // Diccionario temporal para almacenar datos
    var userData = [String: Any]()

    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        // Almacena los datos de la primera vista en `userData`
        userData["clientName"] = nameTextField.text
        userData["clientDni"] = dniTextField.text
        userData["clientTelefono"] = phoneTextField.text
        userData["clientFechaNac"] = birthdatePicker.date
        
        // Realiza la transición a `AdditionalInfoViewController`
        performSegue(withIdentifier: "goToAdditionalInfo", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAdditionalInfo" {
            if let destinationVC = segue.destination as? AdditionalInfoViewController {
                // Pasa `userData` a `AdditionalInfoViewController`
                destinationVC.userData = userData
            }
        }
    }
}
