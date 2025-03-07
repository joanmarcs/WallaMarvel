import Foundation
import UIKit

final class ListHeroesAdapter: NSObject, UITableViewDataSource {
    var heroes: [Hero]
    private let tableView: UITableView
    
    init(tableView: UITableView, heroes: [Hero] = []) {
        self.tableView = tableView
        self.heroes = heroes
        super.init()
        self.tableView.dataSource = self
    }
    
    func updateData(newHeroes: [Hero]) {
        guard !newHeroes.isEmpty else { return }
        
        let startIndex = heroes.count
        let endIndex = startIndex + newHeroes.count - 1
        let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
        
        self.heroes.append(contentsOf: newHeroes)
        
        if startIndex == 0 {
            tableView.reloadData()
        } else {
            tableView.performBatchUpdates({
                tableView.insertRows(at: indexPaths, with: .automatic)
            }, completion: nil)
        }
    }
    
    func deleteData() {
        self.heroes.removeAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListHeroesTableViewCell", for: indexPath) as! ListHeroesTableViewCell
        
        let model = heroes[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}
