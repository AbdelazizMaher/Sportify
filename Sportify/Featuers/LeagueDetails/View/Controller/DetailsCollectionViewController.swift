//
//  DetailsCollectionViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit
import Kingfisher

protocol LeagueDetailsProtocol {
    func reloadUpcomingSection()
    func reloadLatestSection()
    func reloadTeamsSection()
}

class DetailsCollectionViewController: UICollectionViewController, LeagueDetailsProtocol {

    var presenter: LeagueDetailsPresenter!
    var favPresenter = FavPresenter()
    var imgName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         imgName = favPresenter.checkFav(id: Int16(presenter.leagueId)) ? "heart.fill" : "heart"
        let heartButton = UIBarButtonItem(image: UIImage(systemName: imgName),style: .plain,target: self,action: #selector(favoriteButtonTapped))
                                          
        heartButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = heartButton
        
        collectionView.register(
            UINib(nibName: "UpcomingCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "upcoming"
        )
        collectionView.register(
            UINib(nibName: "LatestCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "latest"
        )
        collectionView.register(
            UINib(nibName: "TeamsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "teams"
        )
        
        collectionView.register(UICollectionReusableView.self,forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: "Header")
        collectionView.contentInset.bottom = 80
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return self.UpcomingSection()
            case 1 :
                return self.LatestSection()
            case 2:
                return self.TeamsSection()
            default:
                return nil
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        presenter.getUpcomingEvents()
        presenter.getLatestEvents()
        presenter.getAllTeams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.setTabBarHidden(true)
        }
    }

    @objc private func favoriteButtonTapped() {

        let leagueKey = Int16(presenter.leagueId)
        
        if favPresenter.checkFav(id: leagueKey) {
            let league = LeagueLocal(
                leagueKey: leagueKey,
                leagueName: presenter.leagueName,
                leagueLogo: presenter.leagueLogo ?? "",
                sport: presenter.sportType,
                isFavorite: false
            )
            self.showAlert(title: DELETE_ALERT_TITLE, message:  DELETE_ALERT_MSG ,cancelTitle: DELETE_ALERT_CANCEL,deleteTitle: DELETE_ALERT_OK,onDelete: {
                self.favPresenter.deleteFromCore(objc: league)
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")})
        } else {
            let league = LeagueLocal(
                leagueKey: leagueKey,
                leagueName: presenter.leagueName,
                leagueLogo: presenter.leagueLogo ?? "",
                sport: presenter.sportType,
                isFavorite: true
            )
            favPresenter.addToCore(objc: league)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
    }


    func updateFavoriteButton(isFavorite: Bool) {
      navigationItem.rightBarButtonItem?.image = UIImage(
          systemName: isFavorite ? "heart.fill" : "heart"
      )
      
      UIView.animate(withDuration: 0.2, animations: {
          self.navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: { _ in
          UIView.animate(withDuration: 0.2) {
              self.navigationItem.rightBarButtonItem?.customView?.transform = .identity
          }
      })
    }
    
    func reloadUpcomingSection() {
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func reloadLatestSection() {
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func reloadTeamsSection() {
        collectionView.reloadSections(IndexSet(integer: 2))
    }

    func UpcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        section.orthogonalScrollingBehavior = .continuous

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    func LatestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    func TeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .absolute(150)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        section.orthogonalScrollingBehavior = .continuous

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0: return presenter.upcomingMatches.count
        case 1: return presenter.latestMatches.count
        case 2: return presenter.teams.count
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingCollectionViewCell
            configureUpcomingCell(cell, at: indexPath.row)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestCollectionViewCell
            configureLatestCell(cell, at: indexPath.row)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            configureTeamCell(cell, at: indexPath.row)
            return cell
            
        default:
            fatalError("Unexpected section")
        }
    }
    
    private func configureUpcomingCell(_ cell: UpcomingCollectionViewCell, at index: Int) {
        guard let fixture = presenter.upcomingMatches[index] as? Fixture else { return }
        
        cell.team1Title.text = fixture.homeParticipant
        cell.team2Title.text = fixture.awayParticipant
        cell.eventDate.text = fixture.eventDate ?? fixture.eventDateStart
        cell.eventTime.text = fixture.eventTime
        
        
        let team1Logo = URL(string: fixture.homeParticipantLogo ?? "")
        cell.team1Logo.kf.setImage(with: team1Logo, placeholder: UIImage(named: "placeholder")?.resized(to: CGSize(width: 80, height: 80)))
        
        let team2Logo = URL(string: fixture.awayParticipantLogo ?? "")
        cell.team2Logo.kf.setImage(with: team2Logo, placeholder: UIImage(named: "placeholder")?.resized(to: CGSize(width: 80, height: 80)))
    }
    
    private func configureLatestCell(_ cell: LatestCollectionViewCell, at index: Int) {
        guard let fixture = presenter.latestMatches[index] as? Fixture else { return }
        
        cell.team1Title.text = fixture.homeParticipant
        cell.team2Title.text = fixture.awayParticipant
        cell.eventDate.text = fixture.eventDate ?? fixture.eventDateStart
        
        if let finalResult = fixture.finalResult {
            let components = finalResult.components(separatedBy: "-")
            if components.count >= 2 {
                cell.team1Score.text = components[0].trimmingCharacters(in: .whitespaces)
                cell.team2Score.text = components[1].trimmingCharacters(in: .whitespaces)
            }
        } else if let homeResult = fixture.homeFinalResult, let awayResult = fixture.awayFinalResult {
            cell.team1Score.text = homeResult.contains("(f/o)") ? "(f/o)" : homeResult
            cell.team2Score.text = awayResult.contains("(f/o)") ? "(f/o)" : awayResult
        }
        
        let team1Logo = URL(string: fixture.homeParticipantLogo ?? "")
        cell.team1Logo.kf.setImage(with: team1Logo, placeholder: UIImage(named: "placeholder")?.resized(to: CGSize(width: 80, height: 80)))
        
        let team2Logo = URL(string: fixture.awayParticipantLogo ?? "")
        cell.team2Logo.kf.setImage(with: team2Logo, placeholder: UIImage(named: "placeholder")?.resized(to: CGSize(width: 80, height: 80)))
    }
    
    private func configureTeamCell(_ cell: TeamsCollectionViewCell, at index: Int) {
        let team = presenter.teams[index]
        cell.teamTitle.text = team.teamName
        let teamLogo = URL(string: team.teamLogo  ?? "")
        cell.teamImg.kf.setImage(with: teamLogo, placeholder: UIImage(named: "placeholder")?.resized(to: CGSize(width: 80, height: 80)))
    }
    
    override func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath)

        header.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel(frame: CGRect(x: 16, y: 0, width: collectionView.frame.width - 32, height: 44))
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .label

        switch indexPath.section {
        case 0: label.text = NSLocalizedString("upcoming_title", comment: "hamda")
        case 1: label.text = NSLocalizedString("latest_title", comment: "hamda")
        case 2: label.text = NSLocalizedString("team_title", comment: "hamda")
        default: label.text = ""
        }

        header.addSubview(label)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            if NetworkManager.isInternetAvailable() {
                let storyboard = UIStoryboard(name: "TeamStoryBoard", bundle: nil)
                let teamsVC = storyboard.instantiateViewController(withIdentifier: "team") as! PlayerTableController
                teamsVC.presenter = TeamPresenter(vc: teamsVC, teamID: String(presenter.teams[indexPath.item].teamKey), teamName: presenter.teams[indexPath.item].teamName!)
                navigationController?.pushViewController(teamsVC, animated: true)
            } else {
                showAlert(title: INTERNET_ALERT_TITLE, message: INTERNET_ALERT_MSG, okTitle: DELETE_ALERT_OK)

            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.2) {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                cell.alpha = 0.8
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.2) {
                cell.transform = .identity
                cell.alpha = 1.0
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
            // If using estimated sizes, you might need to reload data too
            self.collectionView.reloadData()
        }, completion: nil)
    }
}
