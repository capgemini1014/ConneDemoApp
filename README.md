Application Overview
------

The iOS application will display 5 days weather forecast. By using swich button off, user can see previous data which will keep as json file in the bundle and by using swich button on (default) will pull the data from API. It has also scroll feature vertically.

MVVM Overview
------

MVVM (Model View ViewModel) is an architectural pattern based on MVC and MVP, which attempts to more clearly separate the development of user-interfaces (UI) from that of the business logic and behaviour in an application. 

Requirements
-----

Swift 5.0 and  Xcode 13.1

    
Project Details
-----
* `APIService.swift` - Calling web API.
* `WeatherInformation.swift,Clouds.swift,Coord.swift, Main.swift, Main.swift, Sys.swift,Weather.swift, Wind.swift, Lisr.Swift, City.swift, ` - Data model.
* `HomeViewModel.swift` - Manage and format the data to be displayed in the views.
* `WeatherCellView.swift` - The cell that contain the weather view.
* `Constants.swift, AsyncImageLoader.swift, Extension.swift, ZoomAndSnapFlowLayout.swift` - Utility classes for the project.
*  `LocalData` - Local storage file.


