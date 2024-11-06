import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Verifica las credenciales antes de hacer la transición
        authenticateUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    func authenticateUser() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(message: "Por favor, ingrese su email y contraseña.")
            return
        }
        
        // Llama a CoreDataManager para verificar el usuario
        if CoreDataManager.shared.isUserValid(email: email, password: password) {
            performSegue(withIdentifier: "goToNextScreen", sender: self)
        } else {
            showAlert(message: "Email o contraseña incorrectos.")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
