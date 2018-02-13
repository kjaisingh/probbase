import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var subjectPicker: UITableView!
    @IBOutlet var coursePicker: UIPickerView!
    
    var IBSubjects = ["English A Language And Literature", "English A Literature", "Business And Management", "Economics", "History", "ESS", "Psychology", "Biology", "Physics", "Chemistry", "Sports Studies", "Computer Science"]
    var IGCSESubjects = ["English Language", "English Literature", "Enterprise", "Economics", "History", "CoScience Biology", "CoScience Physics", "CoScience Chemistry", "Sports Studies", "Computer Science"]
    var APSubjects = ["English Language", "Human Geography", "US History", "World History", "Biology", "Physics 2", "Physics C", "Chemistry", "Computer Science"]
    
    var displayTopics : [String] = []
    var subjects = ["Please select course first"]
    var chosenSubjects: [String] = []
    var courses = ["IB", "IGCSE", "AP"]
    var changed = 0
    var course: String?
    var userCourse: String = ""
    
    var APEnglishLanguage = ["Reading", "Writing"]
    var APHumanGeography = ["Geography Nature And Perspectives", "Populations", "Cultural Patterns And Processes", "Political Organization Of Space", "Agricultural And Rural Land Use", "Industrialization And Economic Development", "Cities And Urban Land Use"]
    var APUSHistory = ["Period 1 1491-1607", "Period 2 1607-1754", "Period 3 1754-1800", "Period 4 1800-1848", "Period 5 1844-1877", "Period 6 1865-1914", "Period 7 1890-1945", "Period 8 1945-1980", "Period 9 1980-Present"]
    var APWorldHistory = ["The Neolithic Revolution", "The Ancient And Classical World", "The Postclassical World", "The Early Modern World", "The Industrial Age", "The Twentieth Century"]
    var APBiology = ["Biochemistry And Energy", "Cellular Processes", "Cell Cycle And Communication", "Genetics And Gene Activity", "Evolution", "Plants Diversity And Ecology", "Biological Systems"]
    var APPhysics2 = ["Fluids", "Thermodynamics", "Electricity And Magnetism", "Optics", "Modern Physics"]
    var APPhysicsC = ["Introduction And Measurements", "Kinematics", "Newton Laws Of Motion", "Work And Energy", "Momentum And Collisions", "Rotational Kinematics And Circular Motion", "Simple Harmonic Motion", "Gravitation", "Charged Particles And Electric Fields", "Electrostatic Fields And Gauss Law", "Electric Potential", "Ohms Law And DC Circuits", "Magnetic Forces And Fields", "Calculating Magnetic Fields", "Electromagnetic Induction"]
    var APChemistry = ["Chemistry Fundamentals", "Types Of Chemical Equations", "Net Ionic Equations", "Gas Laws", "Thermochemistry", "Atomic Structure And Periodicity", "Chemical Bonding", "Liquids Solids And Solutions", "Kinetics", "General Equilibrium", "Acids And Bases", "Buffers And Titrations", "Thermodynamics", "Electrochemistry"]
    var APComputerScience = ["Principles Of Computer Science", "Java Basics", "Elevens Lab", "Arrays And ArrayLists", "Searching And Sorting"]
    
    var IGCSEEnglishLanguage = ["Paper 2", "Paper 3"]
    var IGCSEEnglishLiterature = ["Studied Poetry", "Studied Prose", "Studied Drama", "Unseen Texts"]
    var IGCSEEnterprise = ["Introduction To Enterprise", "Setting Up A New Enterprise", "Skills And Personal Attributes Needed", "Business Opportunities Responsibilities And Risk", "Negotiation", "Understanding finance", "Business Planning", "Markets And Customers", "Help And Support For Enterprise", "Communicating With Others"]
    var IGCSEEconomics = ["Basic Economic Problem", "Allocation Of Resources", "The Individual", "The Private Firm", "Role Of Government In Economy", "Economic Indicators", "Developmental Economics", "International Aspects"]
    var IGCSEHistory = ["Russia And The Soviet Union", "Germany", "Superpower Relations", "The Vietnam Conflict", "The Middle East", "Palestine"]
    var IGCSECoScienceBiology = ["Characteristics Of Organisms", "Cells And Movement", "Plant Nutrition", "Ecology", "Enzymes", "Animal Nutrition", "Plant Transport", "Human Transport", "Respiration", "Coordination And Response", "Homeostasis", "Reproduction", "Inheritance"]
    var IGCSECoSciencePhysics = ["Motion", "Kinetic Theory", "Electricity", "Light And The EM Spectrum", "Forces And Density", "Nuclear Physics", "Work And Power", "Heating", "Electric Circuits", "Waves And Sound", "Magnetism"]
    var IGCSECoScienceChemistry = ["Particles" ,"Bonding", "Periodicity And Stoichiometry", "Acids And Bases", "Rates", "Detective Chemistry", "Metals", "Organic Chemistry", "Electricity And Chemistry"]
    var IGCSESportsStudies = ["Applied Anatomy And Physiology", "Movement Analysis", "Health Fitness And Well Being", "Use Of Data"]
    var IGCSEComputerScience = ["Data Representation", "Communication And Internet Technologies", "Hardware And Software", "Security", "Ethics", "Algorithm Design And Problem Solving", "Programming Concepts", "Databases"]
    
    var IBBiology = ["Statistical Analysis", "Cells", "Chemical Elements And Water", "Genetics", "Ecology And Evolution", "Human Health And Physiology", "HLNucleic Acids And Proteins", "HL Cell Respiration And Photosynthesis", "HLP Plant Science", "HL Genetics"]
    var IBBusinessAndManagement = ["Business Organization And Environment", "Human Resources Management", "Finance And Accounts", "Marketing", "Operations Management"]
    var IBChemistry = ["Stoichiometric Relationships", "Atomic Structure", "Periodicity", "Chemical Bonding And Structure", "Energetics Thermochemistry", "Chemical Kinetics", "Equilibrium", "Acids And Bases", "Redox Process", "Organic Chemistry", "Measurement And Data Processing", "Materials", "Biochemistry", "Energy", "Medical Chemistry"]
    var IBComputerScience = ["System Fundamentals", "Computer Organization", "Networks", "Computational Thinking And Programming"]
    var IBEconomics = ["Microeconomics", "Macroeconomics", "International Economics", "Developmental Economics"]
    var IBEnglishALanguageAndLiterature = ["Language In A Cultural Context", "Language And Mass Communication", "Literature Texts And Contexts", "Literature Critical Study"]
    var IBEnglishALiterature = ["Works In Translation", "Detailed Study", "Literary Genres", "Options"]
    var IBESS = ["Environmental Value Systems", "Environmental Systems And Modeling", "Human Population", "Conservation And Biodiversity", "Pollution Management", "Climate Change"]
    var IBHistory = ["Black Civil Rights Movement", "South African Anti Apartheid Struggle", "India And Pakistan Independence Movements", "Anti Colonial Movements", "Indian Nationalism And Independence", "Traditional East Asian Societies", "Early Modernisation And East Asia Decline"]
    var IBPhysics = ["Measurement", "Mechanics", "Thermal Physics", "Waves", "Fields And Forces", "Electricity", "Atomic And Nuclear", "Energy Production", "Relativity", "Engineering Physics", "Imaging", "Astrophysics"]
    var IBPsychology = ["Biological Level", "Cognitive Level", "Sociocultural Level", "Abnormal Psychology", "Developmental Psychology", "Health Psychology", "Human Relationships", "Sport Psychology", "Qualitative Research Methodology", "Simple Experimental Study"]
    var IBSportsStudies = ["Anatomy", "Exercise Physiology", "Energy Systems", "Movement Analysis", "Skill In Sport", "Measurement And Human Performance", "HL Further Anatomy", "HL Endocrine System", "HL Fatigue", "HL Friction And Drag", "HL Skill Acquisition", "HL Genetics", "HL Exercise And Immunity"]
    
    //Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        label.textAlignment = .center
        label.text = courses[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        course = courses[row]
        switch(course!) {
        case "IB":
            subjects = IBSubjects
            userCourse = "IB"
        case "IGCSE":
            subjects = IGCSESubjects
            userCourse = "IGCSE"
        case "AP":
            subjects = APSubjects
            userCourse = "AP"
        default:
            print("Error")
        }
        subjectPicker.reloadData()
        chosenSubjects = []
        changed = 1
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row]
        if(chosenSubjects.contains(subjects[indexPath.row])) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if changed == 1 {
            chosenSubjects = []
            changed = 0
        }
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                chosenSubjects = chosenSubjects.filter { $0 != subjects[indexPath.row] }
            } else {
                cell.accessoryType = .checkmark
                chosenSubjects.append(subjects[indexPath.row])
            }
        }

        let unique = Set(chosenSubjects)
        chosenSubjects = Array(unique)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursePicker.delegate = self
        coursePicker.dataSource = self
        
        emailTextfield.delegate = self
        emailTextfield.returnKeyType = UIReturnKeyType.next
        passwordTextfield.delegate = self
        passwordTextfield.tag = 1
        passwordTextfield.returnKeyType = UIReturnKeyType.go
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createAlert(title: String, message: String) {
        let errormsg = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:  { (action) in
            errormsg.dismiss(animated: true, completion: nil)
        }))
        self.present(errormsg, animated: true, completion: nil)
    }

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        let unique = Set(chosenSubjects)
        chosenSubjects = Array(unique)
        for element in chosenSubjects {
            print(element)
        }
        
        SVProgressHUD.show()
        FIRAuth.auth()?.createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil{
                if let fberror = FIRAuthErrorCode(rawValue: error!._code){
                    switch fberror {
                    case .errorCodeInvalidEmail:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Registering", message: "The email entered is invalid.")
                        break
                    case .errorCodeEmailAlreadyInUse:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Registering", message: "The specified user is already in use. Please use another email.")
                        break
                    case .errorCodeWeakPassword:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Registering", message: "The password entered must be at least 6 characters long.")
                        break
                    default:
                        SVProgressHUD.dismiss()
                        self.createAlert(title: "Error Registering", message: "There was a connection problem.")
                        break
                    }
                    print(error)
                }
            }
                
            else {
                
                let databaseRef = FIRDatabase.database().reference()
                var userId = FIRAuth.auth()?.currentUser?.email as! String
                userId = userId.replacingOccurrences(of: ".", with: "")
                userId = userId.replacingOccurrences(of: "_", with: "")
                let coursePath = "Users/\(userId)/Course"
                let chosenCourse = ["Course": self.userCourse]
                databaseRef.child(coursePath).childByAutoId().setValue(chosenCourse)
                
                let sortedSubjects = self.chosenSubjects.sorted { $0 < $1 }
                print(sortedSubjects)
                
                for subject in sortedSubjects {
                    
                    let subjectPath = "Users/\(userId)/SubjectList"
                    let trimmedSubject = subject.replacingOccurrences(of: " ", with: "")
                    let chosenSubj = ["User": userId, "Subject": trimmedSubject]
                    //print(trimmedSubject)
                    databaseRef.child(subjectPath).childByAutoId().setValue(chosenSubj)
                    
                    if(self.userCourse == "IB") {
                        switch(trimmedSubject) {
                        case "Biology":
                            self.displayTopics = self.IBBiology
                        case "BusinessAndManagement":
                            self.displayTopics = self.IBBusinessAndManagement
                        case "Chemistry":
                            self.displayTopics = self.IBChemistry
                        case "ComputerScience":
                            self.displayTopics = self.IBComputerScience
                        case "Economics":
                            self.displayTopics = self.IBEconomics
                        case "EnglishALanguageAndLiterature":
                            self.displayTopics = self.IBEnglishALanguageAndLiterature
                        case "EnglishALiterature":
                            self.displayTopics = self.IBEnglishALiterature
                        case "ESS":
                            self.displayTopics = self.IBESS
                        case "History":
                            self.displayTopics = self.IBHistory
                        case "Physics":
                            self.displayTopics = self.IBPhysics
                        case "Psychology":
                            self.displayTopics = self.IBPsychology
                        case "SportsStudies":
                            self.displayTopics = self.IBSportsStudies
                        default:
                            print("Error finding subject \(trimmedSubject)")
                        }
                        
                    } else if(self.userCourse == "IGCSE") {
                        switch(trimmedSubject) {
                        case "EnglishLanguage":
                            self.displayTopics = self.IGCSEEnglishLanguage
                        case "EnglishLiterature":
                            self.displayTopics = self.IGCSEEnglishLiterature
                        case "Enterprise":
                            self.displayTopics = self.IGCSEEnterprise
                        case "Economics":
                            self.displayTopics = self.IGCSEEconomics
                        case "History":
                            self.displayTopics = self.IGCSEHistory
                        case "CoScienceBiology":
                            self.displayTopics = self.IGCSECoScienceBiology
                        case "CoSciencePhysics":
                            self.displayTopics = self.IGCSECoSciencePhysics
                        case "CoScienceChemistry":
                            self.displayTopics = self.IGCSECoScienceChemistry
                        case "SportsStudies":
                            self.displayTopics = self.IGCSESportsStudies
                        case "ComputerScience":
                            self.displayTopics = self.IGCSEComputerScience
                        default:
                            print("Error finding subject \(trimmedSubject)")
                        }
                        
                    } else if(self.userCourse == "AP") {
                        switch(trimmedSubject) {
                        case "EnglishLanguage":
                            self.displayTopics = self.APEnglishLanguage
                        case "HumanGeography":
                            self.displayTopics = self.APHumanGeography
                        case "USHistory":
                            self.displayTopics = self.APUSHistory
                        case "WorldHistory":
                            self.displayTopics = self.APWorldHistory
                        case "Biology":
                            self.displayTopics = self.APBiology
                        case "Physics2":
                            self.displayTopics = self.APPhysics2
                        case "PhysicsC":
                            self.displayTopics = self.APPhysicsC
                        case "Chemistry":
                            self.displayTopics = self.APChemistry
                        case "ComputerScience":
                            self.displayTopics = self.APComputerScience
                        default:
                            print("Error finding subject \(trimmedSubject)")
                        }
                    } else {
                        print("No course selected")
                    }
                    for topic in self.displayTopics {
                        let post = ["User": userId, "Question": "Placeholder"]
                        let trimmedTopic = topic.replacingOccurrences(of: " ", with: "")
                        let path = "Users/\(userId)/\(trimmedSubject)/\(trimmedTopic)"
                        databaseRef.child(path).childByAutoId().setValue(post)
                    }
                }
                SVProgressHUD.dismiss()
                print("User created successfully!")
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        })
    }
}
