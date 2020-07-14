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

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [fill in your required user stories here]
* ...

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* [list first screen here]
   * [list associated required story here]
   * ...
* [list second screen here]
   * [list associated required story here]
   * ...

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
<img src='http://g.recordit.co/bQqmVVzfxh.gif' title='App Wireframe' width='' alt='Video Walkthrough' />

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
