import SwiftUI

struct GameDealCardView: View {
    
    @Binding
    var paths: [Routes]
    
    @Binding
    var gameDeal: GameDeal
    
    let deal: GameDeal
    let dateFormatter = DateFormatter()
    let frameWidth: CGFloat = 370
    let frameHeight: CGFloat = 500
    let frameRadius: CGFloat = 50
    let lineWidth: CGFloat = 10
    
    var body: some View {
        VStack {
            Text(deal.title)
                .padding(.vertical, 2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.white, lineWidth: 10)
                    .frame(width: (frameWidth * 0.67), height: (frameHeight * 0.28))
                AsyncImage(url: URL(string: deal.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case.failure:
                        Text("Unable to load Image")
                            .foregroundStyle(.white)
                    @unknown default: // supress compiler warnings
                        EmptyView()
                    }
                }
                .frame(width: (frameWidth * 0.66), height: (frameHeight * 0.33))
            }
            
            HStack {
                Text("Worth: \(deal.worth)")
                Text("Platforms: \(truncateString(deal.platforms))")
            }
            .foregroundStyle(.white)
            .padding(.vertical, 2)
            
            Text("Published Date: \(truncateString(deal.published_date))")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 2)
                .foregroundStyle(.white)
            
            Text("End Date: \(truncateString(deal.end_date))")
                .multilineTextAlignment(.leading)
                .padding(.vertical, 2)
                .foregroundStyle(.white)
            
            Button("See More Details") {
                paths.append(.details)
                gameDeal = deal
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            
        }
        .frame(width: frameWidth - (lineWidth * 2), height: frameHeight)
        .background(Color(hex: "1b2838"))
        .clipShape(RoundedRectangle(cornerRadius: frameRadius, style:.continuous))
    }
    
    func truncateString(_ sourceString: String) -> String {
        if sourceString.count >= 12 {
            return String(sourceString.prefix(11)) + "..."
        }
        return sourceString
    }
    
}

//https://stackoverflow.com/questions/76468134/how-to-create-a-swiftui-preview-in-xcode-15-for-a-view-with-a-binding
// need this for preview while editing UI
#Preview {
    struct PreviewWrapper: View {
        @State var paths: [Routes] = [Routes]()
        @State var gd: GameDeal = GameDeal(id: 2837, title: "Orcs Must Die! 3 (Epic Games) Giveaway", worth: "$29.99", thumbnail: "https://www.gamerpower.com/offers/1/6633ab18b4e1e.jpg", image: "https://www.gamerpower.com/offers/1b/6633ab18b4e1e.jpg", description: "Get ready to unleash chaos for free with Orcs Must Die! 3 on the Epic Games Store! It's time to slice, dice your way through hordes of pesky orcs in this epic successor to the beloved Orcs Must Die! series. Prepare for a wild ride filled with laughter, strategy, and a whole lot of orc-slaying action. Claim your free copy now and show those repugnant orcs who's boss!", instructions: "1. Click the \"Get Giveaway\" button to visit the giveaway page.\r\n2. Login into your Epic Games Store account.\r\n3. Click the button to add the game to your library", open_giveaway_url: "https://www.gamerpower.com/open/orcs-must-die-3-epic-games-giveaway", published_date: "2024-05-02 11:02:48", platforms: "PC, Epic Games Store", end_date: "2024-05-09 23:59:00", users: 180, status: "Active", gamerpower_url: "https://www.gamerpower.com/orcs-must-die-3-epic-games-giveaway", open_giveaway: "https://www.gamerpower.com/open/orcs-must-die-3-epic-games-giveaway", type: "Game")
        
        var body: some View {
            GameDealCardView(paths: $paths, gameDeal: $gd, deal: gd)
        }
    }
    return PreviewWrapper()
}
