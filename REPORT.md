# Cuisine A la SP

Naam: Lois van Vliet 


Deze applicatie is bruikbaar voor iedereen die zich regelmatig op Science Park bevindt. Studenten/medewerkers kunnen zien welke maaltijden worden geserveerd op Science Park en kunnen deze gerechten 'liken'. De cateraar kan maaltijden toevoegen, verwijderen en veranderen en zo ook feedback krijgen door middel van het aantal 'likes'.

In dit report worden de volgende onderwerpen besproken:
* [Applicatie](#applicatie)
* [Design](#design)
     * [Datastructuur](#datastructuur)
     * [Objecten](#objecten)
     * [Functies](#functies)
* [Process](#process)
     * [Het oorspronkelijke idee](#het-oorspronkelijke-idee)
     * [Uitdagingen](#uitdagingen)
     * [Gebruikersrollen](#gebruikersrollen)


## Applicatie

Deze applicatie is een applicatie die gebruikt kan worden op science park. Het idee is dat er twee gebruikersrollen zijn. Wanneer Cormet (de cateraar) zich inlogt komt hij in een gedeelte terecht waar hij het beschikbare assortiment kan zien en waar hij de mogelijkheid heeft om gerechten toe voegen en prijzen te veranderen. Er zijn twee soortern assortimenten. Je hebt het gedeelte dat dagelijks veranderd, en het gedeelte wat standaard aanwezig is.Op de rechter Screenshot is te zien hoe de cateraar dit kan invullen voor een bepaalde dag. 
De student daarentegen komt in een ander gedeelte terecht. Ook zij kunnen alle gerechten zien, maar hebben de keuze om deze gerechten te liken. Op de linker screenshot hieronder is een voorbeeld te zien met welke gerechten er kunnen zijn. 

![Screenshot](https://github.com/loisie123/Cuisine-Project/blob/master/doc/Schermafbeelding 2017-02-02 om 16.28.30.png)
![Screemshot](https://github.com/loisie123/Cuisine-Project/blob/master/doc/Schermafbeelding 2017-02-02 om 16.29.58.png)


## Design

### Datastructuur

Om een goed idee te krijgen van hoe de functionaliteit in deze applicatie werkt, is het goed om eerst een duidelijk beeld te krijgen van de datastructuur. Voor deze applicatie is gebruik gemaakt van Firebase. Firebase werd gebruikt voor het opslaan van verschillende users en voor het opslaan van verschillende maaltijden. De datastructuur waar de applicatie op gebaseerd is, is te zien in onderstaande afbeelding. Zoals ik hierboven al heb uitgelegd hebben we te maken met twee gebruikersrollen: Cormet en de User. Cormet bepaalt wat de data is die zowel Cormet als de User te zien krijgen. Deze data kan worden opgeslagen onder twee verschillende kopjes in Firebase: “different days” en “standaard-assortiment”. 
Het eerste kopje word vervolgens onderverdeeld in de beschikbare dagen en vervolgens de verschillende menu’s. Terwijl het Standaard Assortiment al direct wordt onderverdeeld in verschillende producten. 
Bij de user wordt voornamelijk standaard informatie opgeslagen, zoals username, email, wachtwoord en profielfoto. Echter wordt er ook bijgehouden welke producten de user precies 'liked'. 
<img src="https://github.com/loisie123/Cuisine-Project/blob/master/doc/Datastructuur.png">

### Objecten

In deze applicatie is er gebruik gemaakt van drie verschillende objecten:

- User
- Week
- Maaltijd

Voor de user werd er gebruikt gemaakt van informatie voor het inloggen en het verkrijgen van een lijst met alle producten die de user heeft geliked. 
Week is een object dat bestaat uit naam van de dag en datum. Dit object word gebruikt bij het verkrijgen van alle beschikbare dagen. 
Maaltijd is waarschijnlijk het meest gebruikte object in deze applicatie. Dit object word geinitialiseerd door verschillende onderdelen: Naam, prijs, likes, type, dag, en een lijst van mensen die het betreffende product hebben geliked. 

Verder bestaat deze applicatie uit functies in de viewcontrollers. Het was waarschijnlijk handiger geweest om de functies om een andere gebruikt te implementeren en meer gebruik te maken van structs en classes. Echter heb ik me in eerste instantie zorgen gemaakt om de functionaliteit in plaats van de mooiheid van de code. Dit is zeker een verbeterpuntje bij het maken van de volgende code.
    

### Functies
In deze applicatie worden meerdere functies hergebruikt, de moeilijkheid in deze functie was voornamelijk het meegeven van de juiste informatie zodat ook de goede informatie uit firebase werd gehaald. Op de afbeelding hieronder zijn de viewcontrollers te zien met daarin de belangrijkste functies. Blauw staat in dit geval voor de Viewcontrollers die een student/medewerker ziet, terwijl rood de viewcontrollers voor de cateraar zijn.    

<img src="https://github.com/loisie123/Cuisine-Project/blob/master/doc/ViewControllers.png">


Cormet bevat het belangrijkste onderdeel, namelijk het toevoegen van data. Deze data moet handmatig ingevoerd worden. Meteen als het gerecht wordt aangemaakt in een van de twee viewcontrollers die hiervoor aangemaakt zijn, worden waardes die nodig zijn voor het maken van de benodigde klasse aangemaakt. 

## Process

### Het oorspronkelijke idee

Om een beter beeld te krijgen van hoe het proces heeft plaats gevonden zal ik nog kort het oorspronkelijke idee herhalen. 
Het idee was om een applicatie te maken waarbij users konden zien wat voor maaltijden er geserveerd zouden worden. Deze maaltijd zouden een cijfer kunnen krijgen. Cormet zou ook kunnen inloggen, echter moeten zij andere views te zien krijgen dan de andere gebruikers. Zij moeten de mogelijkheid krijgen om de menu's van een hele week aan te kondigen. 
Naast dat de Cateraar maaltijden kan toevoegen, moet de student ook de mogelijkheid krijgen om, wanneer een bepaald product niet op het menu staat, dit toe te voegen aan het menu.  

### Uitdagingen

De Uitdagingen die deze applicatie met zich mee zou brengen waren voornamelijk de uitdagingen van werken met Firebase, het werken met twee verschillende gebruikersrollen en het maken van een like en dislikefunctie.

Over het algemeen is de app redelijk hetzelfde gebleven als het oorspronkelijke idee. De belangrijkste verschillen zijn: liken in plaats van becijferen, het kunnen zien van het menu van vandaag en morgen en een normale gebruiker heeft niet meer de mogelijkheid tot het toevoegen van een gerecht. Het becijferen is veranderder omdat het becijferen van een maaltijd een negatieve draai zou kunnen geven aan de applicatie. Mensen zouden gerechten met enen kunnen becijferen, waardoor gemiddeldes erg slecht zouden kunnen worden. Daarom, in plaats van gerechten te becijferen, is dit idee veranderd in het ‘liken’ en ‘disliken’ van een gerecht. 
Een ander verschil met het Oorspronkelijk idee was dat in het proposal ik had aangegeven een app te maken waarbij je de maaltijden van zowel vandaag als die van morgen zou zien. Echter kwam ik hier in moeilijkheden met het opslaan van firebase en de juiste data eruit halen. 
Het laatste verschil heb ik veranderd omdat ik het uiteindelijk geen goed idee vond. Alle data zou al geleverd worden door de cateraar, dus was dit gedeelte niet nodig. 

De volgende uitdaging in het project was het maken van de datastructuur. Dit was een probleem die ik van te voren niet ingecalculeerd had. Door de gehele tijdsperiode heen is deze structuur veranderd. Het begon met een simpele structuur waar  de maaltijden op 1 dag werden opgeslagen. Vervolgens kwam de keuze om meerdere dagen op te slaan. Ook was in eerste instantie nog in de firebase een tussenstap gemaakt tussen de dag en een maaltijd, met als extra 'child' het type gerecht. Echter bleek dit na veel gepuzzel toch veel problemen op te leveren bij het lezen van de data. 

Na een gesprek met een van de locala managers van de Cateraar op Science Park kwam ik erachter dat de er elke dag niet veel veranderde in de cafeteria, maar dat ze van dag op dag vaak kijken wat voor producten er in het magazijn liggen en word er op basis daarvan vaak een gerecht gemaakt. Hierdoor heb ik ervoor gekozen dat je op elk moment van de dag en week nog producten zijn kunnen toevoegen. Ook leek het me dan beter om een extra view aan te maken voor het Standaard assortiment. 

De Like en unLike functie hebben me ook veel kopzorgen bezorgd. Al snel lukte het om dingen te liken, maar dede de buttons niet wat de bedoeling was. Ook het maken van de lijst van favorieten kwam met veel moeilijkheden. Wanneer er producten werden verwijderd uit deze lijst moesten ze wel op de juiste plek in de database werden verwijderd. Dus er moest bijgehouden welke dag, welke soort (dag of standaard) en hoeveel likes. 


### Gebruikersrollen 

De belangrijkste beslissing die ik heb moeten maken had te maken met de grootte van de applicatie. Tijdens de eerste presentaties werd geopperd dat ik me beter kon focussen op een van de twee gebruikersrollen. Ik ben tegen dit advies in gegaan met als belangrijkste reden dat de app niet compleet was zonder een van de twee. Het idee dat ik had was gebaseerd op een betere samenwerking en meer duidelijkheid tussen de twee afzonderlijke groepen.
Een nadeel van deze keuze is de volgende: hierdoor was er te weinig tijd voor alle functies die ik nog had willen implementeren. Om een voorbeeld te noemen van zo'n functie te noemen, had ik voor Cormet nog graag een functie geimplementeerd die gerechten zou onthouden. Dus gerechten die ooit al een keer geweest waren, dat die bewaard werden en 'hergebruikt' konden worden. Echter door gebrek aan tijd is me dit niet gelukt. Een groot voordeel van deze keuze is dat de applicatie kan lopen zonder dat er van buitenaf nog informatie binnen moet stromen en dat het goed werkt voor beiden partijen. Als ik voor een aparte applicatie voor de student had gekozen, dan had er telkens ergens informatie vandaan moeten komen. En als ik me had gericht op Cormet had er een stuk gemist, aangezien het invoeren van data dan geen nut had gehad. Concluderend kan ik stellen dat ik blij ben met de keuze die ik hier heb gemaakt. 


