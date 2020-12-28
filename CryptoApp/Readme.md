Solution:

Design Pattern: App is MVVM based and is using repository pattern. Every module may have following layers:
View (ViewController): It is part of view and displays the data presented by ViewModel
ViewModel: All of businness logic is mentioned here, it prepares data for view. It converts the Data Model received from Service to a readable and display friendly model for View.
Service: Independent Services to fetch data, can be consumed by any ViewModel. It has a model which only transfers relevent information to upper layers.
Repository: It is Data Access Layer which decides weather the data is to be fetched from remote service or from local database. Gets data and feeds to Service. The data fetching logic is hidden from the upper layer.

| View | <- | ViewModel | <- | Service | <- | Repository | <- | Database/ Networking/ Some Other Data source |

besides above Infrastructure layer contains all the helpers, extensions, utilities needed for application work.

Factory pattern is used to provide objects for Dependancy Injection.

https://app.quicktype.io/ is used to convert json to Models. It helps to quickly convert json to Codable Model

Carthage is used for Dependancy Management. Currently only SVGKit is used to display svg images. For test purpose only minimum dependancy is added, in real app some more dpendancies like RxSwit, Swinject, Alamofire etc. can also be added

For now String values are directly used, in real application it will be used from Localized file

# Bitpanda iOS Dev Test.

Create a small lightweight app that displays the data in the attached Masterdata file. The app must have at least 2 screens (AssetsScreen, WalletsScreen) and it should be easy to switch between them.
You can use any library you wish to achieve this task. As for the UI please DO NOT USE __SwiftUI__ 

## Asset Screen

The asset screen must display a list of the cryptocoins, commodities and fiats. The following requirements must be fulfilled:

### General:

- filtering between each of the assets (show only cryptocoins, commodities or fiats).

### Cryptocoin, Commodities:

- Each list item must contain the asset's icon, name, symbol, average price. 
- Each price must have the number of decimals described by precision for fiat price (see cryptocoin/commodity properties in the Masterdata).
- Each price must also show the fiat symbol, as the prices are in euro fiat.
- Each price must take the regional location of the device into account for formatting. For example 1298.99 euros in Austria would be formatted to 1.298,99 € but in the USA, it would be formatted to $1,298.99.

### Fiats:

- Each list item must contain the fiat's icon, name, symbol .
- Only show the fiat that has wallets (see fiat properties in the Masterdata).

## Wallets Screen

The wallets screen must display a list of ALL wallets available grouped by fiat wallets, wallets and commodity wallets. The following requirements must be fulfilled:

### General:

- Each wallet must be in its proper group.
- It is up to you to decide how grouping is achieved, either by showing multiple lists or grouped items and then opening a new screen with the list of the corresponding wallets on selection etc.
- In each wallet group, the wallets must be sorted in a descending order by balance.

### Fiat Wallets, Wallets, Commodity Wallets:

- Each list item must contain the wallet's name, asset symbol, asset icon and the balance.
- If the wallet is the default wallet (see properties in the Masterdata), mark it in a meaningful and visible way.
- Do not display deleted wallets (see properties in the Masterdata).
- Make sure the fiat wallets are design-wise distinguishable from wallets or commodity wallets. 


## Bonus:
- Implement a nice UI with animations.
- Fully support darkmode while taking into account the right logo for each mode.


GOOD LUCK!

