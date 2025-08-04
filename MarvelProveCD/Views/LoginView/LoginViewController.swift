//
//  LoginViewController.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/1/25.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    var tableVC = MavelTableViewController()
    private var managedObjectContext: NSManagedObjectContext!
    
    var logo: UIImageView?
    var loginButton: UIButton?
    var emailTextField: UITextField?
    var passwrodTextField: UITextField?
    var messaging: UILabel?
    var register: UIButton?
    
    
    
    override func loadView() {
        let loginView = LoginView()
        
        
        //Tenemos los objetos en la ui
        logo = loginView.getLogoImageView()
        loginButton = loginView.getButtonLoginView()
        emailTextField = loginView.getEmailView()
        passwrodTextField = loginView.getPassworfView()
        messaging = loginView.getMessageLvl()
        register = loginView.getRegister()
        
        //asigno la view
        view = loginView
    }
    
    
    
    
    override func viewDidLoad() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        loginButton?.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        register?.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        checkCurrentSession()
    }
    
    
    
  
    
    //MARK: Registro
    @objc func handleRegister() {
        // Muestra una alerta si los campos están vacíos
        guard let user = emailTextField?.text, !user.isEmpty,
              let pass = passwrodTextField?.text, !pass.isEmpty else {
            print("El correo y la clave no pueden estar vacíos para registrarse.")
            return
        }
        
        // Llama a la función de registro con el texto de los campos
        registerNewUser(user: user, pass: pass)
    }
    
    func registerNewUser(user: String, pass: String) {
        let newUser = Users(context: managedObjectContext)
        newUser.user = user
        newUser.pass = pass
        newUser.isLogged = false
        
        do {
            try managedObjectContext.save()
            print("Usuario \(user) registrado exitosamente.")

            emailTextField?.text = ""
            passwrodTextField?.text = ""
        } catch {
            print("Error al guardar el nuevo usuario: \(error.localizedDescription)")
        }
    }
    
    //MARK: Chequeo de datos
    
    func checkCurrentSession() {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isLogged == %@", NSNumber(value: true))
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if results.first != nil {
                
                print("Un usuario ya está logueado.")
                show(tableVC, sender: nil)
                // Muestra nuestra siguiente view si el usuario ya inicio sesion previamente
            }
        } catch {
            print("Error al verificar la sesión: \(error.localizedDescription)")
        }
    }
    
    func checkUser(user: String, pass: String) {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@ AND pass == %@", user, pass)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if let loggedUser = results.first {
                // Usuario y contraseña correctos
                print("Login exitoso para: \(loggedUser.user ?? "")")
                
                // Actualizar el estado de sesión a 'true'
                loggedUser.isLogged = true
                
                // Guardar los cambios
                try managedObjectContext.save()
                
                // Navegar a la pantalla principal
                show(tableVC, sender: nil)
                
            } else {
                // Usuario o contraseña incorrectos
                print("Credenciales inválidas")
                // Mostrar una alerta al usuario
            }
        } catch {
            print("Error al buscar usuario: \(error.localizedDescription)")
        }
    }
    
    
    
    @objc func handleLogin() {
        guard let email = emailTextField?.text, !email.isEmpty,
              let password = passwrodTextField?.text, !password.isEmpty else {
            // Muestra una alerta si los campos están vacíos
            print("Los campos no pueden estar vacíos")
            return
        }
        
        checkUser(user: email, pass: password)
    }
}
