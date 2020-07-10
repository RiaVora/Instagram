# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **16** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [x] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [x] If the user enters an empty username or password for login or signup, they get an error message
- [x] If the user tries to sign out, they will get an alert with the name of their account confirming their signout
- [x] The details view of each post is scrollable only if the caption is longer than the page
- [x] The posts on Instagram cycle through the same posts with infinite scrolling available
- [x] By clicking the profile photo, the user can switch their profile photo

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Best practices in saving data and new attributes of objects to Parse
2. How to allow the user to choose whether they want to take a photo or choose from their camera roll

## Video Walkthrough

Here's a walkthrough of implemented user stories:

- User can sign up and log in with that new account. If the user tries to put in empty fields or an incorrect login, it errors.

<img src='http://g.recordit.co/eOxbHJ9n9U.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- The logged-in user persists and the user can log out

<img src='http://g.recordit.co/hg0Nw3F51E.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- The user can choose a photo, write a caption, and post it

<img src='http://g.recordit.co/wkOXM8ez3d.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- The user can refresh posts, have unlimited scrolling, and see a details view of each post

<img src='http://g.recordit.co/1lGuoGqiTu.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- The user can view their pictures in their profile photo with a details view

<img src='http://g.recordit.co/SjH7VAPxMD.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- The user can change their profile picture by clicking on their profile picture

<img src='http://g.recordit.co/9eEJSDiWup.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIFs created with [Recordit](http://recordit.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://cocoapods.org/pods/DateTool) - formatting for Date and Time
- [Parse](https://cocoapods.org/pods/Parse) - Parse Objects and communication

## Notes

I encountered a few challenges when attempting to save a profile image attribute to the User object in Parse. Through this process I learned how to correctly create a column in Parse, how to reference that column, how to adjust when the column is null, and how to save the attribute back to Parse.

## License

    Copyright [2020] [Ria Vora]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
