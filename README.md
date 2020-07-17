# Yeet
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
[Description of your app]

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
- **Mobile:**
- **Story:**
- **Market:**
- **Habit:**
- **Scope:**

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
* [ ] The current signed in user is persisted across app restarts
* [ ] User can see 20 posts with song reviews
* [ ] User can view profile view with the user profile picture, username, and Spotify login
* [ ] User can view username, profile picture, username, song title, artist title, and song review on timelineview
* [ ] User can see song selection
* [ ] User can use the search bar to search for songs
* [ ] User can use the search bar to look for keywords
* [ ] User can pull to refresh post
* [ ] In the Details view, user can see Album cover, song title, artist title, and can compose a song review and share it

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* Login - Parse
   * User can login
   * User can sign up
* Login - Spotify and Youtube
   * User can Login
* TimeLine
   * User can see youtube playlist
   * User can see profile image
* Detail View
   * User can see all songs within selected playlist
   * User can being the transfer of playlist from Youtube to Spotify 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Login/Sign up
* Music selection

**Flow Navigation** (Screen to Screen)

* Login/ Sign up
   * One time login and log out w/ persisted log in
* Music Selection
   * Selection of playlist and toggle song selection
 

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
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
