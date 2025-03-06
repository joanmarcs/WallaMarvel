import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    
    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.cancelFetch()
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [Hero]) {
        listHeroesProvider?.updateData(newHeroes: heroes)
    }
    
    public func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedHero = listHeroesProvider?.heroes[indexPath.row] else { return }
        presenter?.didSelectHero(selectedHero)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalHeroes = listHeroesProvider?.heroes.count, totalHeroes > 0 else { return }

        if indexPath.row == totalHeroes - 1 {
            presenter?.getHeroes()
        }
    }
}

