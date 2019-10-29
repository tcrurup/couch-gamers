# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

*Database Creation
    -run $rake db:migrate to create the database

*Initial Use
    -type 'rails server' into the command line to start the server and navigate your browser to localhost/:3000 to go to a sign up page.  Create the first user accounts to begin

    -Also accomodates for omniauth if you would like to login through facebook.  If logged in this way you have an option to create a password on the site so the user can either login through Facebook or a username and password for all future visits.

    -Users can all create developers and will become owners of that development studio upon creation.  Only one developer is allowed to be owned per user.  

    -Through a developer a user can create a game that is linked to that developer if the user owns or works for the development studio.  Only the owner can currently add and remove users from their developer studio

    -You can use the menu bar to navigate through the 3 main resources, users, games, and developers.

    -Only people who work for developers are allowed to delete games

    -If a developer is removed or the owner deletes it all games will be removed as well.

