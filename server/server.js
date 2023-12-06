const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;


// Use cors middleware
app.use(cors());

// Define a route that returns a JSON response
app.get('/api/buildings', (req, res) => {
  const jsonData = {
    "batiments":[
        {
            "numero" : "8C",
            "nom" : "Chartreuse",
            "entree":[
                {
                    "id" : 1,
                    "latitude" : 45.641415,
                    "longitude" : 5.869132
                },
                {  
                    "id" : 2,
                    "latitude" : 45.641241,
                    "longitude" : 5.868448
                },
                {  
                    "id" : 3,
                    "latitude" : 45.641637,
                    "longitude" : 5.868490
                },
                {  
                    "id" : 4,
                    "latitude" : 45.641585,
                    "longitude" : 5.868267
                },
                {  
                    "id" : 5,
                    "latitude" : 45.641782,
                    "longitude" : 5.868195
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "8A",
            "nom" : "Service logistique de site",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.642061,
                    "longitude" : 5.868208
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "8B",
            "nom" : "Belledonne",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.641844,
                    "longitude" : 5.868502
                },
                {  
                    "id" : 2,
                    "latitude" : 45.641927,
                    "longitude" : 5.868758
                },
                {  
                    "id" : 3,
                    "latitude" : 45.642020,
                    "longitude" : 5.869228
                },
                {  
                    "id" : 4,
                    "latitude" : 45.642153,
                    "longitude" : 5.869884
                },
                {  
                    "id" : 5,
                    "latitude" : 45.642258,
                    "longitude" : 5.870368
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "8D",
            "nom" : "Iseran",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.641995,
                    "longitude" : 5.869231
                },
                {  
                    "id" : 2,
                    "latitude" : 45.641713,
                    "longitude" : 5.869369
                },
                {  
                    "id" : 3,
                    "latitude" : 45.641908,
                    "longitude" : 5.869640
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "10",
            "nom" : "Hautecombe / Bibliothèque",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.641285,
                    "longitude" : 5.869833
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "8E",
            "nom" : "Mont Cenis",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.642153,
                    "longitude" : 5.869884
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "6",
            "nom" : "Tarentaise / EVE",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.641456,
                    "longitude" : 5.870299
                },
                {  
                    "id" : 2,
                    "latitude" : 45.641396,
                    "longitude" : 5.870497
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "4B",
            "nom" : "Lauzière",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.640924,
                    "longitude" : 5.870721
                }
            ],
            "description" : "1 Amphi 4B21, Des salles de cours de 4B22 à 4B28",
            "image" : ""
        },

        {
            "numero" : "4A",
            "nom" : "4 Cantons",
            "entree":[
                {  
                    "id" : 1,
                    "latitude" : 45.640583,
                    "longitude" : 5.870861
                },
                {  
                    "id" : 2,
                    "latitude" : 45.640611,
                    "longitude" : 5.871056
                },
                {  
                    "id" : 3,
                    "latitude" : 45.640361,
                    "longitude" : 5.871083
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "2",
            "nom" : "Bauges",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.640180,
                    "longitude" : 5.870916
                },
                {  
                    "id" : "2",
                    "latitude" : 45.640129,
                    "longitude" : 5.871171
                },
                {  
                    "id" : "3",
                    "latitude" : 45.63992802973709,
                    "longitude" : 5.870956274365371
                },
                {  
                    "id" : "4",
                    "latitude" : 45.64004992458458,
                    "longitude" : 5.87066726634333
                }
            ],
            "description" : "",
            "image" : ""
        },
        
        {
            "numero" : "4C",
            "nom" : "Entremonts",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64063220319647,
                    "longitude" : 5.870365580603327
                },
                {  
                    "id" : "2",
                    "latitude" : 45.64023907184465,
                    "longitude" : 5.870530918913502
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "4E",
            "nom" : "Vanoise",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64032771055697,
                    "longitude" : 5.870201735301933
                },
                {  
                    "id" : "2",
                    "latitude" : 45.64029971589199,
                    "longitude" : 5.8702959480117975
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "4D",
            "nom" : "Beaufortain",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.640493208146594,
                    "longitude" : 5.870225288480253
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "12A",
            "nom" : "Maurienne",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64087402480223,
                    "longitude" : 5.869313278791107
                },
                {  
                    "id" : "2",
                    "latitude" : 45.64096130134638,
                    "longitude" : 5.869558231836755
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "12B",
            "nom" : "Combe de Savoie",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.641153,
                    "longitude" : 5.869151
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "14",
            "nom" : "Halle Tachnique Polytech",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64057760581669,
                    "longitude" : 5.869059128496149
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "21",
            "nom" : "Chablais",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64228999916085,
                    "longitude" : 5.865718664462077
                },
                {  
                    "id" : "2",
                    "latitude" : 45.642335849972454,
                    "longitude" : 5.86597098901996
                }
            ],
            "description" : "",
            "image" : ""
        },

        {
            "numero" : "RU",
            "nom" : "Chautagne",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64222840630476,
                    "longitude" : 5.864950194049017
                },
                {  
                    "id" : "2",
                    "latitude" : 45.64262525688443,
                    "longitude" : 5.864450866686971
                }
            ],
            "description" : "",
            "image" : ""
        },
        {
            "numero" : "Accueil Crous",
            "nom" : "Les Arves, Cité universitaire du Bugey",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.64246068712046,
                    "longitude" : 5.866589999996407
                }
            ],
            "description" : "",
            "image" : ""
        },
        {
            "numero" : "5A",
            "nom" : "Hélice",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.641307888274945,
                    "longitude" : 5.871413568662828
                },
                {  
                    "id" : "2",
                    "latitude" : 45.6412243013362,
                    "longitude" : 5.871346814995912
                }
            ],
            "description" : "",
            "image" : ""
        },
        {
            "numero" : "3",
            "nom" : "Pole Montagne",
            "entree":[
                {  
                    "id" : "1",
                    "latitude" : 45.640447552192,
                    "longitude" : 5.872431468550684
                }
            ],
            "description" : "",
            "image" : ""
        }
    ]
};

  res.json(jsonData);
});

// Start the server
app.listen(port, '::', () => {
  console.log(`Server is running on port ${port}`);
});
