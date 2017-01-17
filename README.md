# Cuisine-A-la-UvA

Cuisine A la UvA
Lois van Vliet
10438033


This application will be useful for every visitor, staff or student at University of Amsterdam. The user will be able to see what kind of meals are served and it’s appreciation with other users. Each Meal can be reviewed and grated by the user. If there is a Meal that is not known, the user can add the new dish and immediately add a grade. 


Project proposal. 

Every day, students and staff at UvA  are coming to the cafeteria to get lunch or dinner. And every day they are surprised with the menu. Sometimes this is a pleasant surprise, sometimes not so much. Users of this application will no longer be surprised because they will know what Cormet (the current caterer) has to offer. 
Also the caterer will be able to login and add their meals. They will have different views than the users. The idea will be that the caterer are able to announce the menu’s throughout the whole week. 

Cuisine a La UvA will be an application were users can see what kind of food Cormet has to offer on that same day. They will be able to login, choose their faculty, see the served dishes, rate the menu, see the prices, and when something is not on the menu, the user can add it. 

The data
The dataset that will be used is information that will be gathered at Cormet. Also users can add sandwiches or food that are missing in the dataset. All this information will be saved in firebase.  

Separat Parts in the application
The application can be divided in two main parts. The user part and the Cormet part. They will be discussed separately. 

Cormet. 
Cormet will be able to fill in the menu’s that differ from day to day. They will be able to login via a different frame then the users will see. An example of this is shown below. 

![ScreenShot](https://raw.github.com/loisie123/Cuisine-A-la-UvA/master/doc/Schermafbeelding 2017-01-09 om 23.10.04.png)

User part. 
The users will be able to register and login. They will see different actions. You can see this also in de view below. 
-	Show todays menu
  o	In this view users can see the different dishes
  o	The user can rate the meals from 1 to 10.
-	Shows tomorrows menu.
-	Create new dish.
-	Show all dishes with their mean ratings. 
-	Show all dishes for one particular user. 

Each option will be a button that will send the user to another view. 

![ScreenShot](https://raw.github.com/loisie123/Cuisine-A-la-UvA/master/doc/Schermafbeelding 2017-01-09 om 23.10.56.png)
![ScreenShot](https://raw.github.com/loisie123/Cuisine-A-la-UvA/master/doc/Schermafbeelding 2017-01-09 om 23.21.38.png)
![ScreenShot](https://raw.github.com/loisie123/Cuisine-A-la-UvA/master/doc/Schermafbeelding 2017-01-09 om 23.25.33.png)


Limitations.
Limitations can occur with getting the data from Cormet. If this isn’t possible all users will be asked to save dishes they have seen and so the information will be gathered while using the app. 
Another technical problem will be with saving everything in firebase. So we want the menu’s from cormet to be public for every user. But these menu’s will get ratings from different users but we only want to see the means of these ratings.  Furthermore for each user we want to save what dish they ate and save their own ratings seperate from the public ratings. It will be possible to overcome, nevertheless it will take a lot of time to sort it out. 

Reviews of similar applications. 
There are different applications that save and rate meals. The next two apps are examples that can be used to save meals. 

Food tracker app:
https://github.com/RMA101/FoodTracker/blob/master/FoodTracker/Meal.swift

In this app meals can be saved and rated. Classes named Meals are present to save a meals. This app can be very useful as an example for saving different dishes and rating them. 

Restaurant app:
https://github.com/sirhazman07/FoodPin/tree/master/FoodPin
In this app you can search for different restaurants and rate the restaurants. This app also saves different restaurant in the classe Restaurant with their ratings. Just like the previous app, this app can be very useful as an example for saving different dishes and rating them. 


 


