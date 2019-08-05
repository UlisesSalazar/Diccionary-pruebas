//
//  ViewController.swift
//  diccionary
//
//  Created by Karim Ulises Salazar Garcia on 7/30/19.
//  Copyright © 2019 Karim Ulises Salazar Garcia. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
 
    
    let cellIF = "A"
    

    var twoDimensionalArray = [
        namesExpandable(isExpanded: true , names:  ["Xilacina", "Flunicin", "Ranitidina", "Clorafenicol"]),
        namesExpandable(isExpanded: true , names:  ["Xilacina", "Flunicin", "Ranitidina", "Clorafenicol"]),
        namesExpandable(isExpanded: true , names:  ["clorafenicol","Clunixin de meglumine", "clunixinal"]),
    namesExpandable(isExpanded: true , names:  ["Deslorin", "Dextran", "Defazolin"]),
        namesExpandable(isExpanded: true , names:  ["Eparicina", "Estraidol"])
    ]
   
    //how do medicin grup
   
  var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
       
        print ("reload animation of indexPath")
        
    
         //build all the indexPaths we want to reload
    
    var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            
            }
        }
        //for index in twoDimensionalArray[0].indices {
        //let indexPath = IndexPath(row: index, section: 0)
          //  indexPathsToReload.append(indexPath)
       // }
        
     
  showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ?
            UITableView.RowAnimation.right: .left
       
    tableView.reloadRows(at: indexPathsToReload, with:animationStyle)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
       
        
        //search controller seeker
        //navigationItem.searchController = searchController
        //searchController.searchBar.delegate = self
 
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Especifico", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Medicamentos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIF)
        
    
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel ()
        label.text = "A"
       
        label.backgroundColor = UIColor.white
      
        return label
        
        
        /*let button = UIButton(type: .system)
        button.setTitle("Cerrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)

    button.tag = section
        
        
        return button*/
        
    }
    @objc func handleExpandClose(button: UIButton) {
        
        
        print ( "Expanding an close section")
        
        let section = button.tag
        
        //EXPANGIN SECTION A CLOSE DELETING ROWS
        var indexPaths = [IndexPath] ()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
            }
       
        let isExpaned = twoDimensionalArray [section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpaned
        
        button.setTitle(isExpaned ? "abrir" : "cerrar", for: .normal )
    
        
        if isExpaned {
             tableView.deleteRows(at:indexPaths, with: .fade)
            
        }else{
            tableView.insertRows(at: indexPaths, with: .fade)
           
            
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded{
            
           return 0
        }
        
         return twoDimensionalArray[section].names.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellIF, for: indexPath)
        
     // let name = self.names[indexPath.row]
        
       // let name = indexPath.section == 0 ? names [indexPath.row] : cNames[indexPath.row]
        let name = twoDimensionalArray [indexPath.section].names[indexPath.row]
        cell.textLabel?.text = name
        if showIndexPaths {
            cell.textLabel?.text = "\(name)    Section:\(indexPath.section)     Row:\(indexPath.row)"
        }
        return cell
        
    }
//searchBar

}
