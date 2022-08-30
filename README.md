# Web & Mobile Development
Flutter Tech Assessment

## In this app below mentioned techs used;

1. Flutter SDK
2. Docker
3. Microsoft Dynamics 365

## Platforms that app can works;

1. Web (Preferrably Google Chrome)
2. Android 4 (KITKAT) and above
3. IOS 10 and above

## Live Links from Project;

1. [Android Test Link ](https://play.google.com/store/apps/details?id=com.digitalpratix.techassignment)
2. [Apple (IOS) TestFlight Link](https://testflight.apple.com/join/7VCuLqf3)
3. [Web Link (Not available now)](https://www.google.com)

## Project Functions

1. Microsoft Dynamics 365 Cloud Data fetch
2. Main Page

* List of All Accounts
- Searchbar for filtering (Dynamically filter all letters write & delete)
- Filtering option based on State Code and StateOrProvince variable
- UI View Change based on selection from grid or list (default list)

3. Detail Page

* Detail informations consists of selected Account
- Animations and UI Designing

## Packages Used in this Project Coding

1. provider: ^6.0.3 (State Management)
2. http: any (REST API Calls)
3. nb_utils: ^4.4.6 (Additional Needs for UI/Data)
4. flutter_vector_icons: ^1.0.0 (Icon Usage esp. for Feather)
5. intl: any (Format Change)

## Packages Used in This Project Testing

1. flutter_test
2. integration_test
3. flutter_lints: ^1.0.0
4. mocktail: ^0.2.0

## Project Structure

1. Blocs --> Change Notifiers
	+ account_bloc
	+ theme_bloc
2. Models --> Object Models
	+ account_model
	+ theme_model
3. Screens
	+ account_screen (and its components)
	+ account_detail_screen (and its components)
4. Services
	+ account_service

5. Utilities
	+ constants

## Explanation

1. Get Ready Data Environments
	+ After adjust the Environment on powerplatform
	+ Connect Power Apps
	+ Login Azure Portal and adjust credentials
2. Data Fetch
	+ Create an endpoint (for this purpose) for getting access token
	+ Create for Account list fetch endpoint
	+ Test these via POSTMAN
3. Flutter Part
	+ Above mentioned structure designed & start developing
	+ Coming Data for Account list as json convert to account_model objects
	+ Provider package used for this lists

	+ State Code and StateOrProvince variables stored in a list which fetched from this account list (uniquely stored/avoid from duplication) [_stateFilterList]
	+ This async action created for network get & post request/response time. This actions stored in bool value and state listening this data changes [_isReady]
	+ There is also list created for showing filtered actions _accountSearchList
	
	+ Service part is only used by send & get requests from REST API (account_service)

	+ For UI actions Elements designed based on MediaQuery variables for being responsive for web & mobil (for many type  UI sizes)
	
	+ List & Grid Types are two types of list supported by same list but ui is different.

	+ Page elements divided by components in order to fill the clean code principles

	+ App is designed and developed with possible future update infrastructure
		+ Multiprovider (For more type of data fetch and differentiate between them)
		+ Theme Bloc (Dark & Light Theme)

4. Testing
	+ For Unit testing is the logic test. For this project account_bloc tested.
		+ Initial values accuracy
		+ Created Mock Service and Mock Data
		+ Simulating the Data Fetch process
			+ isReady false
			+ await data fecth
			+ check mock data
			+ isReady true check
	
	+ For widget testing
		+ Check Displayed widgets such as AppBar
		+ Check CupertinoActivityIndicator
		+ Wait Async Data fetch
		+ Checking fetched Account Card Widgets from Mock Service
	
	+ For Integrated Testing
		+ Simulate the Main Screen Creation
		+ Navigation test for specific Mock data object form Account list Page to this Account detail Page

5. Docker Part
	+ Create Dockerfile
	+ Prepare the server.sh (which includes build script)
	+ "docker build . -t flutter_docker" run
	+ "docker run -i -p 8080:5000 -td flutter_docker" run img container


## Aplication Screen Captures
1. Screen Captures
	+ Web
	+ Android
	+ IOS (Apple) included

[Drive link is public](https://drive.google.com/file/d/1SHZI0dFLi5KAtdSQAFUZX1ViUwe4EoMP/view?usp=sharing)


2. Test Results
	+ Unit Test


https://user-images.githubusercontent.com/48150826/182869327-42bab882-4e6b-43f7-ae7d-8259c565624a.mov



	+ Widget Test


https://user-images.githubusercontent.com/48150826/182868931-a646a45d-00f7-4839-aa45-e08e7af31b4b.mov


	+ Integration Test


https://user-images.githubusercontent.com/48150826/182868369-2f0e97c1-d700-49e0-8957-039469cbaf7f.mov




























 


