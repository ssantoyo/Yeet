# Yeet
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Yeet is a moblie application for iOS where users can search songs on Spotify and post reviews for all others to see. The purpose of this app is to allow users to get a sense of what others think about songs and for the user to share their own thoughts and opinions. 

### App Evaluation
- **Category:** Lifestyle/Entertainment
- **Mobile:** This app would be primarily developed for mobile but would a good platform to have on a computer as well. Many people typically listen to music on the go, so having it mobile is more viable. 
- **Story:** Allows users to search for songs and create a review based on their thoughts of what they thought about the song.
- **Market:** Any Individual could choose to use this app, since this app will be open to all genres it will allow for a larger scope of people to use it. 
- **Habit:** This app can be used as often as the user likes, with it being a mobile app it can be used at any time and place. 
- **Scope:**  First the app would start off purely for song reviews, but would potentially evolve into a music streaming application to broaden the usage. Also, growing the scope past Spotify and adding Apple Music, Amazon Music, Pandora, etc.

## Product Spec

**Required FBU Must-have Stories**

* [x] User can see app has multiple views
* [x] User can log in/log out of your app as a user
* [x] User can sign up with a new user profile
* [ ] Your app incorporates an external library to add visual polish
* [x] User can use the camera to take a picture and do something with the picture 
* [ ] Your app use an animation (doesn’t have to be fancy) (e.g. fade in/out, e.g. animating a view growing and shrinking)
* [x] Your app uses gesture recognizers (e.g. double tap to like, e.g. pinch to scale) 
* [ ] Your app contains at least one more complex algorithm 
* [x] Your app interact with a database (e.g. Parse) 
* [x] Your app integrates with a SDK (e.g. Google Maps SDK, Facebook SDK)

**Required Must-have Stories**
* [ ] User sees app icon in home screen and styled launch screen
* [x] User can sign up to create a new account using Parse authentication
* [x] User can log in and log out of his or her account
* [x] The current signed in user is persisted across app restarts
* [ ] User can see 20 posts with song reviews
* [ ] User can view profile view with the user profile picture, username, and Spotify login
* [ ] User can view username, profile picture, username, song title, artist title, and song review on timelineview
* [ ] User can see song selection
* [ ] User can use the search bar to search for songs
* [ ] User can use the search bar to look for keywords
* [ ] User can pull to refresh post
* [ ] In the Details view, user can see Album cover, song title, artist title, and can compose a song review and share it

**Optional Nice-to-have Stories**

*  Optionals are still TBD

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
    * The user is prompted to log in to gain access to theri profile information and feed
* Compose post screen - User can write a review for the song they have choosen
    * Allows users to select a song of choice and write a review 
* Feed
    * Once post has been shared it will be able to be viewed
* Profile
    * Lets the user login into Spotify
    * User can see profile picture and username


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Login/Sign up
* Music selection
* Profile
* Feed

**Flow Navigation** (Screen to Screen)

* Login/ Sign up
   * One time login and log out w/ persisted log in
* Music Selection
   * Jumps to details view where you write review
 * Profile
    * Spotify Sign in
 * Feed
    * Scroll through feed and search based off keywords
 

## Wireframes
<img src='http://g.recordit.co/HH2dbjXOsq.gif' title='App Wireframe' width='' alt='Video Walkthrough' />

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
This section includes the data objects that will be used for the app

### Models
## Model: Post
| Column 1     | Column 2        | Column 3                                    |
| ------------ | --------------- | ------------------------------------------- |
| objectID     | String          | Unique id for the user post( default field) |
| createdAt    | Date            | Date when post is created(default field)    |
| author       | Pointer to User | Post author                                 |
| image        | File            | Image uploaded by author                    |
| likesCount   | Number          | Number of likes per post                    |
| review       | String          | Review by the author of the song it refers to |
| commentCount | Number          | Number of comments per post                 |

## Model: User
| Property         | Type   | Description |
| ---------------- | ------ | ----------- |
| objectID | String | Unique id for the user post (default field) |
| Spotify username | String | User's Spotify username |
| password | String | User's password |
| username | String | User's username |

## Model: Song
| Property     | Type | Description |
| ------------ | ---- | ----------- |
| objectID | string |Unique id for the user post (default field)             |
| title | string | title of the song   |
| artist | string  | name of the artist            |

### Networking

## List of network requests by screen
* Login Screen
   * (Create/POST) Create a new user object
   
* Timeline Screen
   * (Read/GET) Query posts for user's feed
   * (Read/GET) Query posts by user

* Song Selection Screen
   * (Read/GET) Query List all songs where user is author of account
   
* Create Post/Details Screen
   * (Create/POST) Create a new post object
   * (Create/POST) Create a new review on a post
   
* Profile Screen
   * (Read/GET) Query logged in user object
   
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
