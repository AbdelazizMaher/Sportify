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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            heightDimension: .fractionalHeight(0.27)
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
            heightDimension: .fractionalHeight(0.27)
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
            heightDimension: .fractionalHeight(0.2)
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
        cell.team1Logo.kf.setImage(with: team1Logo, placeholder: UIImage(named: "man"))
        
        let team2Logo = URL(string: fixture.awayParticipantLogo ?? "")
        cell.team2Logo.kf.setImage(with: team2Logo, placeholder: UIImage(named: "man"))
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
            cell.team1Score.text = homeResult
            cell.team2Score.text = awayResult
        }
        
        let team1Logo = URL(string: fixture.homeParticipantLogo ?? "")
        cell.team1Logo.kf.setImage(with: team1Logo, placeholder: UIImage(named: "man"))
        
        let team2Logo = URL(string: fixture.awayParticipantLogo ?? "")
        cell.team2Logo.kf.setImage(with: team2Logo, placeholder: UIImage(named: "man"))
    }
    
    private func configureTeamCell(_ cell: TeamsCollectionViewCell, at index: Int) {
        let team = presenter.teams[index]
        cell.teamTitle.text = team.teamName
        let teamLogo = URL(string: team.teamLogo  ?? "")
        cell.teamImg.kf.setImage(with: teamLogo, placeholder: UIImage(named: "man"))
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
        case 0: label.text = "Upcoming"
        case 1: label.text = "Latest"
        case 2: label.text = "Teams"
        default: label.text = ""
        }

        header.addSubview(label)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "TeamStoryBoard", bundle: nil)
            let teamsVC = storyboard.instantiateViewController(withIdentifier: "team") as! PlayerTableController
            teamsVC.presenter = TeamPresenter(vc: teamsVC, teamID: String(presenter.teams[indexPath.item].teamKey), teamName: presenter.teams[indexPath.item].teamName!)
            navigationController?.pushViewController(teamsVC, animated: true)
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
}
