# EveryCoins
![ev 001](https://github.com/andwecrawl/Mobbie/assets/120160532/899d8d8f-9f41-4978-82a9-af5634bceb8e)

<br>

## 앱 소개
실시간으로 암호 화폐의 가격을 빠르게 확인하고 관심있는 상품을 지갑에서 편리하게 볼 수 있는 앱
<br>
<br>
## 기능 소개
- 실시간으로 암호 화폐의 가격을 확인할 수 있습니다.
- 세부 항목에서 특정 코인의 호가창을 볼 수 있으며 업비트 로그인을 통해 매수/매도가 가능합니다.
  - 카카오 로그인과 애플 로그인을 지원합니다.
- 관심 있는 항목을 내 지갑에 등록 후 빠르게 확인할 수 있습니다.
- 특정 코인을 위젯으로 등록하여 관찰할 수 있습니다.

<br>
<br>

## 사용한 기술
- `SwiftUI`, `Combine`, `WidgetKit` , `Charts`
- `Alamofire`, `AuthenticationServices`
- `MVVM`, `Singleton`, `Router` 
<br>
<br>

## 기능 소개
- **SwiftUI와 Combine, MVVM**을 이용하여 **인터페이스와 로직이 명확히 분리**된 **반응형 UI**를 구현했습니다.
- **WebSocket** 통신을 이용하여 실시간으로 데이터가 변화하는 **List와 Bar/Line Charts**를 구현했습니다.
- `@Namespace`와 `machedGeometryEffect` 함수를 활용하여 사용자의 Interaction에 따라 자연스럽게 객체가 이동하는 화면 전환 애니메이션을 구현했습니다.
- 
- Kakao 로그인과 **AuthenticationServices**를 활용하여 **Apple 로그인**을 구현했습니다.
- WidgetKit을 이용하여 사용자 커스텀이 가능한 `Intent Widget`을 구현했습니다.
<br>
<br>

## TroubleShooting
### 1. 소켓 통신이 일어나는 View가 쌓이면서 일어나는 과도한 소켓 통신
- 문제 상황
  - 소켓 통신하는 View에서 화면 전환을 통해 다른 뷰가 쌓이거나 App이 background 상태로 동작하는 경우, 소켓을 담당하는 viewModel이 deinit이 되지 않아 과도한 소켓 통신이 일어났다.
- 해결 방법
  - 화면 전환이 일어날 때, 소켓 통신이 지속적으로 필요한 상황과 그렇지 않은 상황을 구분하여 viewModel이 deinit 될 때 이외에도 소켓을 닫거나 변경하는 처리를 해주었다. FeedView에서 DetailView 화면으로 넘어가게 될 때는 소켓 통신이 끊기지 않고 유지되다가 자연스럽게 다른 통신으로 이어져야 했고, 아예 다른 화면으로 넘어갈 경우나 app이 background로 돌아갈 경우에는 임의로 소켓 연결을 끊어 주어 메모리 누수와 기기의 과부화를 방지했다.

```swift
struct FeedView: View {
    
    @StateObject
    var viewModel: FeedViewModel
    @State var searchQueryString = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image(.coin)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: 40, height: 40)
                    .padding(.top, 4)
                
                SearchBarView(searchText: $searchQueryString)
                    .onSubmit(of: .text) {
                        viewModel.searchQuery.send(searchQueryString)
                    }
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(viewModel.showingCoinList, id: \.id) { item in
                            NavigationLink {
                                DetailView(viewModel: DetailViewModel(coin: item))
                            } label: {
                                CoinCell(coin: item)
                                    .frame(maxWidth: .infinity)
                            }
                            Rectangle()
                                .fill(.trustGray.opacity(0.6))
                                .frame(height: 1)
                                .frame(maxWidth: 420)
                        }
                    } header: {
                        ExchangeHeader()
                            .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .clipped()
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                if !viewModel.coinList.isEmpty {
                    viewModel.manageSocket()
                }
            }
            .onDisappear {
                SocketManager.shared.closeWebSocket()
            }
        }
    }
}
```
<br>

### 2. User Interaction이 있을 때마다 WalletView 객체의 배경색이 랜덤으로 변화함
- 문제 상황
  - WalletView 내에서 User Interaction이 발생할 때마다, 객체의 배경색이 랜덤으로 바뀌었다.
- 해결 방법
  - 객체의 데이터에 랜덤 색상값을 기본으로 넣어주어 뷰가 갱신 시 바뀌지 않도록 했다. SwiftUI 특성상 @State 변수가 변화할 때마다 뷰를 새로 그리게 되는데, 기존의 방식으로는 매번 뷰를 새로 그릴 때마다 배경색이 랜덤으로 초기화되었기 때문에 발생하는 문제였다.

이전 코드
```swift
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .background(Color.random())
                .fill(data.color)
                .frame(height: 150)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -120, y: -40)
                        .scaleEffect(1.6, anchor: .topLeading)
                        .frame(width: 200, height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
        ... ...
```

바꾼 코드
```swift
struct WalletModel: Hashable {
    let color = Color.random()
    let index: Int
    let korName: String
    let engName: String
    let marketCode: String
    var tradePrice: Double
    var change: Double
    var changePrice: Double
    var accTradePrice: Double
    
    init(index: Int, coin: CoinModel) {
        self.index = index
        self.korName = coin.korName
        self.engName = coin.engName
        self.marketCode = coin.marketCode
        self.tradePrice = coin.tradePrice
        self.change = coin.change
        self.changePrice = coin.changePrice
        self.accTradePrice = coin.accTradePrice
    }
}
```
```swift
    func cardView(_ data: WalletModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .background(Color.random())
                .fill(data.color)
                .frame(height: 150)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -120, y: -40)
                        .scaleEffect(1.6, anchor: .topLeading)
                        .frame(width: 200, height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
    ... ...
```

<br>

### 3. API 통신 결괏값을 위젯에 반영하기
- 문제 상황
  - API 통신을 통해 받아온 코인 데이터가 View에 제대로 반영이 되지 않았다. 
사용자가 입력한 값을 설정한 아이디/비밀번호 조건에 일치하는지 일차적으로 유효성 검증한 후에, 사용자가 버튼을 탭했을 때 서버 통신을 통해 가입 가능한 아이디인지 확인하는 로직을 구현해 주어야 했다. 그러기 위해서는 순서가 중요했는데, 정규표현식을 통해 사용자가 입력한 값을 먼저 검증한 후에 사용자가 버튼을 탭하고 서버 통신을 통해 확인해야 했다.
- 해결 방법
  - Widget의 View를 그리기 전 Provider에서 해당 위젯에 필요한 데이터를 fetch한 후 entry를 통해 전달해 주었다. 이는 Widget의 특성 때문이었는데, Widget은 static한 상태로 동작하기 때문에 내부에서 새로운 데이터를 받아 적용할 수 없다.

```swif
tstruct Provider: AppIntentTimelineProvider {
    
    init() {
        getData()
    }
    
    func getData() {
        NetworkManager.shared.fetchData(api: .candleCharts(marketName: "KRW-BTC"), type: [CandleModel].self) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.candleModels = success
            case .failure(let failure):
                print("error: \(failure)")
            }
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), models: NetworkManager.shared.candleModels)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, models: NetworkManager.shared.candleModels)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, models: NetworkManager.shared.candleModels)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}
```


```swift
struct CoinWidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.white.gradient)
            VStack(alignment: .leading) {
                Text("🪙 Bitcoin")
                    .font(.headline).bold()
                ChartView(candles: entry.models)
            }
            .padding()
        }
    }
}
```
<br>
