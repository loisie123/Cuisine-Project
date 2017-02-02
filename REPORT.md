# Cuisine A la SP

Naam: Lois van Vliet 


Deze applicatie is bruikbaar voor iedereen, zowel een student als voor de cateraar. Studenten/medewerkers kunnen zien welke maaltijden worden geserveerd op Science Park en kunnen deze gerechten 'liken'. De cateraar kan maaltijden toevoegen, verwijderen en veranderen en zo ook feedback krijgen door middel van aantal 'likes'.


In dit report worden de volgende onderwerpen besproken:
* [Applicatie](#applicatie)
* [Design](#design)
     * [Datastructuur](#datastructuur)
     * [Viewcontrollers](#viewcontrollers)
* [Process](#process)
     * [Het oorspronkelijke idee](#het-oorspronkelijke-idee)
     * [Uitdagingen](#uitdagingen)
     * [Gebruikersrollen](#gebruikersrollen)


## Applicatie

Op de Universiteit van Amsterdam op locatie Science Park zitten menig studenten en medewerkers dagenlang op locatie. Aangezien niet iedereen altijd een lunchpakketje mee heeft, levert Cormet een dagelijkse voorraad aan eten en drinken. Er zijn elke dag andere soorten soep, broodjes en warme maaltijden beschikbaar. Omdat veel studenten en ook werknemers ’s ochtends wel eens in tijdnood zitten, is het handig wanneer informatie over het menu al eerder op de dag bekend zou zijn. 
Deze app lost dit probleem op. Studenten en werknemers kunnen zich aanmelden en kunnen zien welke producten er op die dag verkrijgbaar zijn en welke producten er ook standaard geleverd worden. De gebruikers kunnen elk gerecht liken, zodat men ook weet welk gerecht in de goede smaak valt en welke iets minder. Hieronder is een Screenshot te zien van hoe een lijst met gerechten eruit ziet. 

![Screenshot](https://github.com/loisie123/Cuisine-Project/blob/master/doc/Schermafbeelding 2017-02-02 om 16.28.30.png)
![Screemshot](https://github.com/loisie123/Cuisine-Project/blob/master/doc/Schermafbeelding 2017-02-02 om 16.29.58.png)

Daarnaast kan de cateraar (in de geval Cormet) ook inloggen op de app. Allee komen zij in een ander gedeelte terecht. Zij kunnen menu’s toevoegen, veranderen en verwijderen. Ook kunnen zij zien hoe deze producten in de smaak vallen. Dus zo werkt het ook als feedback. Hieronder is een screenshot te zien waar de cateraar de maaltijden kan toevoegen. 



## Design

### Datastructuur

Om een duidelijker beeld te krijgen van hoe de functionaliteit precies werkt,  is het handig om eerste een duidelijker beeld van de datastructuur te krijgen. Zo hebben we te maken met twee verschillende gebruikersrollen. Cormet bepaald alle data. Dit wordt opgeslagen binnen twee verschillende kopjes in Firebase: “different days” en “standaard-assortiment”. 
Het eerste kopje word vervolgens onderverdeeld in de beschikbare dagen en vervolgens de verschillende menu’s. Terwijl het Standaard Assortiment al direct wordt onderverdeeld in verschillende menu’s. Hieronder is te zien hoe deze datastructuur precies in elkaar zit. 

<img src="https://github.com/loisie123/Cuisine-Project/blob/master/doc/Datastructuur.png">

### Viewcontrollers

De functies die ik heb geimplementeerd zijn opgeslagen in een aparte extension. Echter worden verscheidene functies in dezelfde viewcontrollers gebruikt. Hieronder is een afbeelding van hoe verschillende viewcontrollers met elkaar samenhangen. Blauw staat in dit geval voor de Viewcontrollers die een student/medewerker ziet, terwijl rood de viewcontrollers voor de cateraar zijn. 

<img src="https://github.com/loisie123/Cuisine-Project/blob/master/doc/ViewControllers.png">

Het belangrijkste van de app is dat er data beschikbaar is. Deze worden ingevuld door Cormet in CormetStandardAssortimentViewController en in SubmitMealViewController. 

Vanuit CormetWeekViewController en userWeekDaysViewController. Worden vanuit firebase de verschillende dagen opgehaald met gebruik van het object week. 

#### Cormet
Cormet bevat het belangrijkste onderdeel, namelijk het toevoegen van data. Deze data moet handmatig ingevoerd worden. Meteen als het gerecht wordt aangemaakt in een van de twee viewcontrollers die hiervoor aangemaakt zijn, worden waardes die nodig zijn voor het maken van de benodigde klasse aangemaakt. 

De object Week wordt gebruikt wanneer we willen weten welke dagen uberhaupt al beschikbaar zijn en wat er op die dagen wordt gegeten. Dankzij de DeleteFunction kunnen de dagen die geweest zijn volledig uit Firebase verwijderen en ook direct uit de tableView. 
Alleen Cormet heeft deze mogelijkheden. 

Dankzij de Change function kan cormet ook nog de prijs veranderen wanneer zij die eenmaal hebben ingevuld. Dit is voornamelijk handig voor de producten in het standaard assortiment.

Belangrijke functies in dit gedeelte van de app zijn dan ook:
SaveMeal()  en getMeal().
 

#### User

Bij de User is het niet mogelijk om dingen te veranderen. Het is voornamelijk belangrijk dat de gebruiker producten kan liken en daardoor kan zien of deze in de smaak vallen. Belangrijke functies hierbij zijn:

getMeal()
de Getmeal function haalt alle informatie op in slaat deze op in een lijst met meerdere objecten. Hierdoor word het gemakkelijker om de objecten te selecteren en te updaten met wanner ze worden geliked of gedisliked. 

likeFunction:
De likeFunction maakt gebruik van de verschillende objecten. waaruit de cellen van een tableView bestaan. Door een maaltijd te ‘liken’ wordt het object aangeroepen wordt deze opgeslagen onder een apart kopje van de user. Daarnaast worden de likes geupdate en word de persoon in kwestie aan de lijst van peopleWhoLike toegevoegd. 

DislikeFunction
De DislikeFunction heeft hetzelfde idee als de likefunction, alleen worden de likes geupdate en de persoon uit peoplWhoLike verwijderd. 


## Process

### Het oorspronkelijke idee

Every day, students and staff at UvA  are coming to the cafeteria to get lunch or dinner. And every day they are surprised with the menu. Sometimes this is a pleasant surprise, sometimes not so much. Users of this application will no longer be surprised because they will know what Cormet (the current caterer) has to offer. 
Also the caterer will be able to login and add their meals. They will have different views than the users. The idea will be that the caterer are able to announce the menu’s throughout the whole week. 

Cuisine a La UvA will be an application were users can see what kind of food Cormet has to offer on that same day. They will be able to login, choose their faculty, see the served dishes, rate the menu, see the prices, and when something is not on the menu, the user can add it. 

### Uitdagingen

De Uitdagingen die deze applicatie met zich mee zou brengen waren voornamelijk de uitdagingen van werken met Firebase, het werken met twee verschillende gebruikersrollen en het maken van een like en dislikefunctie.

 Over het algemeen is de app redelijk hetzelfde gebleven als voorgesteld in het project proposal. Het belangrijkste verschil met het project proposal is het becijferen van een maaltijd een negatieve draai zou geven aan de applicatie. Dus in plaats van gerechten te becijferen is dit idee veranderd in het ‘liken’ en ‘disliken’ van een gerecht. 
Een ander verschil met het project proposal was dat in het proposal ik had aangegeven een app te maken waarbij je de maaltijden van zowel vandaag als die van morgen zou zien. Echter kwam ik hier in moeilijkheden met het opslaan van firebase en de juiste data eruit halen. 

De volgende uitdaging in het project was het maken van de datastructuur. Dit was een probleem die ik van te voren niet ingecalculeerd had. Door de gehele tijdsperiode door is deze structuur telkens veranderd. Het begon met een simpele structuur waar alleen de maaltijden op een bepaalde dag in werden opgeslagen. Waar vervolgens de keuze kwam om meerdere dagen op te slaan. Ook was in eerste instantie nog in de firebase een tussenstap gemaakt tussen de dag en een maaltijd, met als child het type gerecht. Echter bleek dit na veel gepuzzel toch veel problemen op te leveren bij het lezen van de data. 
Na een gesprek met een van de locala managers van Science Park kwam ik erachter dat de er elke dag niet veel veranderde in de cafeteria, maar dat ze van dag op dag vaak keken wat voor producten er in het magazijn liggen en word er op basis daarvan extra broodjes gemaakt. Dit betekende dat de manier van invoeren waarop ik het idee had gebaseerd niet helemaal mogelijk was. 
Ik heb er daarom vervolgens voor gekozen om een extra viewcontroller aan te maken met daarin het standaard assortiment, maar ook de verschillende data aan te houden. 
Doordat de data nu elk moment van de dag ingevoerd kan worden, kan het rekening houden met dat er nog kort van te voren een bepaald gerecht kan worden ingevoerd. In plaats van het oorspronkelijke idee waar Cormet voor een week lang moest invoeren wat er op het menu stond. 

In de tussentijd waren de like en unlike functie al opgezet. Deze functie gaven minder problemen dan ik had verwacht. Echter waren er meer problemen met de constrains van de bijbehorende buttons dan met de functies zelf. Een ander probleem waar een week lang tegenaan werd gelopen was het probleem dat de button soms helemaal verdween. Hoewel het id van de betreffende persoon niet in het lijstje peoplewholike werd gevonden. 

Hoe meer naar het eind van dit project toe werd het maken van de verschillende viewcontrollers en hun betreffende table views steeds makkelijker. Hoewel ik er 2.5 week over had gedaan om de datastructuur compleet te maken en informatie uit Firebase te halen. Heeft het vervolgens een dag geduurt om de andere viewcontrollers aan te maken. 

Een ander probleem waar ik veel tegenaan ben gelopen in dit proces was voornamelijk het programma en github zelf. Het programma stopte soms met werken of besloot bepaalde constraints totaal anders te interpreteren dan dat ik ze had ingesteld. Dit soort kleine probleempjes hebben meer tijd in beslag genomen dan ik van te voren had bedacht. 


### Gebruikersrollen 

De belangrijkste beslissing die ik heb moeten maken had te maken met de grootte van de applicatie. Tijdens de eerste presentaties werd bedacht dat ik me misschien beter op een gedeeltje kon focussen dan op twee(cormet of de student). Ik ben tegen dit advies in gegaan met als belangrijkste reden dat ik vond dat de app niet compleet was zonder 1. Het idee dat ik had was gebaseerd op een betere samenwerking en meer duidelijkheid tussen de twee afzonderlijke groepen. Dus niet zozeer 1 groep apart was de doelgroep. Een nadeel van deze keuze is geweest dat er te weinig tijd was voor functies die ik nog had willen implementeren. Om een voorbeeld te noemen had ik voor Cormet nog graag een functie geimplementeerd die gerechten die ooit ingevuld waren, dat die bewaard werden, zodat ze hergebruikt zouden kunnen worden. Echter door gebrek aan tijd is me dit niet gelukt. Een groot voordeel van deze keuze is dat de applicatie kan lopen zonder dat er van buitenaf telkens nog informatie binnen moet stromen. Het is een werkende applicatie die los van alles zou kunnen staan. Als ik voor een aparte applicatie voor de student had gekozen, dan had er telkens ergens informatie vandaan moeten komen. En als ik me had gericht op Cormet had er een stuk gemist, aangezien het invoeren van data dan geen nut had gehad. Concluderend kan ik stellen dat ik blij ben met de keuze die ik hier heb gemaakt. 


