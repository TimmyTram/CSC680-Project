import SwiftUI


enum Loadable<T> {
    case loading
    case failure(Error)
    case success(T)
}

struct ContentView: View {
    
    let gamerPowerService: GamerPowerServiceProtocol = GamerPowerService()
    let mockGamerPowerService: GamerPowerServiceProtocol = MockGamerPowerService()
    
    @State
    var screenState: Loadable<[GameDeal]> = .loading
    
    
    var body: some View {
        VStack {
            switch screenState {
            case .loading:
                ProgressView()
            case .failure(let error):
                Button("Retry") {
                    screenState = .loading
                    
                    // mock service call
                    fetchMockGames()
                    
                    // real service call
                    //fetchGames()
                }
                Text(error.localizedDescription)
            case .success(let data):
                ListDealView(deals: data)
            }
        }
        .onAppear {
            // real service
            //fetchGames()
            
            // mock service
            fetchMockGames()
        }
    }
    
    func fetchGames() {
        gamerPowerService.fetchSales(callback: { (result: Loadable) -> Void in
            screenState = result
        })
    }
    
    func fetchMockGames() {
        mockGamerPowerService.fetchSales(callback: { (result: Loadable) -> Void in
                screenState = result
        })
    }
    
}

#Preview {
    ContentView()
}
