# Process

## Dag 2 Woensdag 12-01

Project proposal is gemaakt. 
Vanochtend eerste meeting gehad. Tot de conclusie gekomen dat ik beter gebruik kan maken van likes in plaats van ratings. 
Daarnaast heb ik de keus gemaakt om te beginnen met een app waarbij je kan zien wat er vandaag en morgen te eten is in het restaurant. 
De maaltijden worden niet in een vaste database opgeslagen. Dus telkens als de cateraar zegt wat er is, begint het aantal likes weer op nul. 

## Dag 3 Donderdag 13-01

veel problemen gehad met firebase. Maar dat werkt nu eindelijk. Wel ervoor gekozen om de app iets simpeler nog te maken. 
Dus dat een gebruiker een maaltijd kan toevoegen ga ik voor nu nog maar even achterwege laten. 


## Dag 4 Vrijdag 14-01

Vandaag presentaties gegeven en alle views aangemaakt. Ik moet erover gaan nadenken om de app te specialiseren op 1 gebruiker. Dus niet een app maken di gebruikt kan worden door zowel de studenten als de cateraar, maar dat ik me richt op de student. 



## Dag 5 Zondag 15-01

Toch ervoor gekozen om nog even met cormet te werken. De view voor cormet is aangemaakt en werkt nu. Alleen nog data toevoegen. Is misschien  ook handig om nog centrale functie toe te voegen waardoor de code korter wordt. Maar dat kan later nog. 

- to do:  kortere code in cormetSubmitViewController. 

## Dag 6 Maandag 16-01

Bezig geweest met het maken van een classe van users 


## Dag 7 Dinsdag 17-01

Github weer goed gezet, zodat het wat overzichtelijker is. Verder heb ik users aangemaakt en kan ik nu de verschillende users zien in mijn app. 
Verder deed Xcode vandaag vreemd. Minsten anderhalf uur daarmee bezig geweest om hem weer goed te laten werken. 

## Dag 8 Woensdag 18-01

Classe meal.swift werkt nu goed. Hier moet ik ook nog kijken naar of ik de code nog korter kan maken. Voor nu werkt hij in ieder geval. 

## Dag  9 Donderdag 19-01

De beginselen van de like en unlike functie zijn er. maar werkt nog niet optimaal 

## Dag 10 Vrijdag 20-01

Like en unlike werken inmiddels. Maar nog steeds problemen met wanneer ik de app open hij niet laat zien welke al geliket zijn door de persoon
De favorieten pagina is ook gemaakt, maar moet nog aangepst worden. Een cell wordt nog niet verwijderd zodra een like wordt 'geunliked'

allee viewcontrollers moeten ook nog moooie constraints krijgenen mooi aangekleed worden


## dag 11 maandag 23-01

settings pagina aangemaakt. 
alleen het veranderen van de email werkt nog niet helemaal.Wachtwoord veranderen en username en foto veranderen werkt wel. 



## dag 12 dinsdag 24-01

Ik heb hulp gekregen bij het oplossen van het probleem van mijn table view controller, door een post en observe te sturen. 
bezig met het maken van een standaard assortiment. Echter het lezen uit firebase gaat nog niet zoals gewenst. Dat moet morgen opgelost worden. 


## dag 13 Woensdag 25-01

Standaard assortiment werkt. maar de categorien moeten nog wel gehardcoded worden

- todo zorgen dat de categorien al van te voren worden meegestuurd. 

Het liken gaat ook weer fout. De likes veranderen niet als je iets unliked hoewel het in firebase wel verwijderd word. 
Nog geen idee hoe ik dit moet oplossen 
Daarnaast ook nog een manier bedenken om de data beter op te slaan. Zodat cormet kan wijzigen en verwijderen. 
het installeeren van een UIDatePicker kan hierbij helpen. 


## dag 14 Donderdag 26-01

Alle viewcontrollers zijn gemaakt en alles werkt nu grof weg. De Cateraar kan nu alle gerechten zien, ze wijzigen en deleten en ook weer nieuwe toevoegen. 
ook het liken en unliken van een gerecht gaat goed (van de user)

bugs en todo list die ik tot nu toe ben tegen gekomen:
algemeen:


- state restoration
- code opschonen
- misschien een swift bestand aanmaken met functies die door de hele code gebruikt worden.
- opmaak en constraints.
- referenties 
- readme aanpassen


cormet:

- zodra de naam van een gerecht wijzigd is het niet meer mogelijk om het gerecht te liken. Dit komt door de naamverandering, alleen is de tak in firebase niet veranderd. 
- Als er niks in de week staat (alles is verwijderd) dan crasht hij
- het zelf kunnen toevoegen can categorien
- opmaak van deze gebruiker
- login scherm met twee gebruikersrollen (ipv dit gehardcoded)
- alertcontrollers toevoegen. (bij deleten van dingen en dagen)
- submitMealscontroller nog aanpassen op basis van het huidige idee (next day button misschien verwijderen)

user:

- nieuwe user kan een eerder gelikete gerecht niet liken (knop is afwezig)
- favorite zijn de like knoppen sowieso verdwenen 
- email adres ook kunnen veranderen 
- opmaak
- logout knop even omzetten naar de goede logout. 
- settings knop

# day 15 Vrijdag 27-01

Mijn code in BetterHubCode gegooid. Er kwam naar voren dat mijn codes voornamelijk te lang waren en daarnaast ook te vaak herhaald werden. Dit moet ik volgende week gaan oplossen. Problemen wel dat sommige codes heel erg hetzelfde lijken, maar op te veel plaatsen net wat anders zijn waardoor ik de code niet dubbel kan gebruiken. Hier moet ik dus keuzes gaan maken om bepaalde stukjes code te gaan herhalen of dat ik kleine stukjes code toch in een aparte functie zet. 
Zo heb ik er nu bijvoorbeeld voor gekozen om de functies waarbij ik informatie ophaal toch nog apart te nemen. Ik kan er over nadenken om de functies die in zowel cormet als in de user voorkomen die wel te hergebruiken. 


# day 16 zondag 28-01

Veel alertcontrollers toegevoegd om het gemak te vegroten. Ook veel functies in de cormet ViewController korter kunnen maken door gebruik van externe functies. nu nog kijken hoe ik verschillende viewcontrollers met elkaar zou kunnen koppelen. 
Een ander punt waar ik nog vast loop is het punt dat wanneer ik de naam van een dish wil wijzigen dat het wijzigen wel lukt, maar vervolgens kun je deze niet meer liken. Dit komt doordat de key naam niet veranderd waardoor de like functie hem niet goed kan vinden. Moet dus een manier vinden om de key te veranderen. Of misschien moet ik overwegen om dan een hele nieuwe dish aan te maken en deze te verwijderen. 
Ook heb ik een manier gevonden om verschillende soorten eten/drankjes aan te laten maken. Echter zijnd e verschillende categorien nog gehardcode. Mocht ik nog tijd hebben zou ik dit nog willen veranderen. Maar voor nu is het belangrijk dat de andere functies allemaal vlekkeloos lopen. 


