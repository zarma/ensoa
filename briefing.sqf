// JIP
waitUntil {!(isNull player)};
waitUntil {player==player};   

//definitions des notes

_text = "problème non initialisé";

switch (playerSide) do
{
        case west :
        {
                _text = ". <br/><br/>
bla bla west.<br/>";
        };
        case east :
        {
            _text = "bla bla est. <br/><br/>
";
        };
        case resistance :
        {
                // Objectifs du camp Indépendant
        };
        case civilian :
        {
            _text = "Zargabad. <br/><br/>
Rencontrez Mahmoud.<br/>";
        };
};

_d3 = player createDiaryRecord["Diary", ["Briefing", _text]];

_d2 = player createDiaryRecord["Diary", ["Gameplay", "tous les rôles sont tenus par des humains, donc jouer le jeu pour la réussite de la partie.<br/>
<br/>
Utiliser des canaux différents sur ACRE.<br/>
Mahmoud et le reporter doivent convenir d'un canal commum avant la partie.<br/>
"]];

_d1 = player createDiaryRecord["Diary", ["Informations",
"Matériel disponible :<br/>
- hélicoptères<br/>
- voitures<br/>
- camions<br/>
- ...<br/>
<br/>
"]];
