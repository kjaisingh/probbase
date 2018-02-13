//
//  DisplayQuestions.swift
//  Flash Chat
//
//  Created by Karan Jaisingh on 10/21/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class DisplayQuestions: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var subjects: UIPickerView!
    @IBOutlet var questionsList: UITextView!
    var pickerData: [String] = [String]()
    
    var textPassed: String = ""
    
    //var imagePassed = UIImage()
    
    var finalQuestions: [String] = []
    var editedQuestions: [String] = []
    var retrievedSubjects: [String] = []
    var course : String = ""
    var subject = ""
    var topic = ""
    var userId = ""
    
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

    
    var displayTopics = ["Select subject"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (retrievedSubjects.count)
        } else {
            return displayTopics.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        if(component == 0) {
            label.text = retrievedSubjects[row]
        } else {
            label.text = displayTopics[row]
        }
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            subject = retrievedSubjects[row]
            if(self.course == "IB") {
                switch(subject) {
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
                    print("Error finding subject \(subject)")
                }
                
            } else if(self.course == "IGCSE") {
                switch(subject) {
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
                    print("Error finding subject \(subject)")
                }
                
            } else if(self.course == "AP") {
                switch(subject) {
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
                    print("Error finding subject \(subject)")
                }
            } else {
                print("No course selected")
            }
            self.subjects.selectRow(0, inComponent: 1, animated: false)
            self.pickerView(self.subjects, didSelectRow: 0, inComponent: 1)
            pickerView.reloadComponent(1)
        } else {
            topic = displayTopics[row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        subjects.delegate = self
        subjects.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        var userRef = FIRAuth.auth()?.currentUser?.email as! String
        userRef = userRef.replacingOccurrences(of: ".", with: "")
        userRef = userRef.replacingOccurrences(of: "_", with: "")
        
        let coursePath = "Users/\(userRef)/Course"
        let courseRef = FIRDatabase.database().reference().child(coursePath)
        courseRef.observe(.childAdded) { (snapshot) in
            let snapVal = snapshot.value as! Dictionary<String, String>
            self.course = snapVal["Course"]!
        }
        
        let subjectPath = "Users/\(userRef)/SubjectList"
        let subjectRef = FIRDatabase.database().reference().child(subjectPath)
        subjectRef.observe(.childAdded) { (snapshot) in
            let snapVal = snapshot.value as! Dictionary<String, String>
            let subjPassed = snapVal["Subject"]
            self.retrievedSubjects.append(subjPassed!)
            self.subjects.reloadComponent(0)
            self.subjects.reloadComponent(1)
        }
        self.subjects.reloadComponent(0)
        self.subjects.reloadComponent(1)
        questionsList.text = textPassed
        print("Questions: \(textPassed)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func upload(_ sender: Any) {
        let wholeText = questionsList.text
        let output = Array(wholeText!.characters)
        let length = wholeText!.count
        var countTotal = 0
        //Formatting outputted text
        var count:Int
        count = 0;
        var cw: String = ""
        for i in output {
            count += 1
            countTotal += 1
            if(i == "\n" && count > 5) {
                cw += String(i)

                if(countTotal < output.count) {
                    if(output[countTotal] == "\n") {
                        var firstChar = Array(cw)[0]
                        if (firstChar == "\n") {
                            let index = cw.index(cw.startIndex, offsetBy: 1)
                            cw = cw.substring(from: index)
                        }
                        editedQuestions.append(cw)
                        cw = ""
                        count = 0
                    }
                }
            } else {
                cw += String(i)
            }
        }
        post()
        self.performSegue(withIdentifier: "goHomeFromDisplayQs", sender: self)
    }
    
    func post() {
        userId = FIRAuth.auth()?.currentUser?.email as! String
        userId = userId.replacingOccurrences(of: ".", with: "")
        userId = userId.replacingOccurrences(of: "_", with: "")
        let databaseRef = FIRDatabase.database().reference()
        let databaseRef2 = FIRDatabase.database().reference()
        
        let trimmedSubject = subject.replacingOccurrences(of: " ", with: "")
        let trimmedTopic = topic.replacingOccurrences(of: " ", with: "")
        let path = "Users/\(userId)/\(trimmedSubject)/\(trimmedTopic)"
        let pathPublic = "\(course)/\(trimmedSubject)/\(trimmedTopic)"

        for q in editedQuestions {
            let post = ["User": userId, "Question": q]
            databaseRef.child(path).childByAutoId().setValue(post)
            databaseRef2.child(pathPublic).childByAutoId().setValue(post)
        }
    }
}
