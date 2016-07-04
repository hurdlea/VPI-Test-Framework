# Vpi_constants.rb

# ============================================================================ #
# Constants derived from the FPE schemas                                       #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Inital Version                                      #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

GENRES = {
  2 => [
    "Entertainment:Undefined",
    "Entertainment:Action/Thriller",
    "Entertainment:Adventure",
    "Entertainment:Comedy",
    "Entertainment:Mystery/Horror",
    "Entertainment:Drama",
    "Entertainment:Educational",
    "Entertainment:Light Ent",
    "Entertainment:Lifestyle/Doco",
    "Entertainment:Reality",
    "Entertainment:Arts",
    "Entertainment:Sci Fi/Fantasy",
    "Entertainment:War/Western",
    "Entertainment:Talk Shows",
    "Entertainment:Special Events"
  ],
  4 => [
    "Movie:Undefined",
    "Movie:Action/Adventure",
    "Movie:Animation",
    "Movie:Documentaries",
    "Movie:Drama",
    "Movie:Erotic",
    "Movie:Sci-Fi/Fantasy",
    "Movie:Foreign",
    "Movie:Horror",
    "Movie:Musical/Dance",
    "Movie:Thriller/Suspense",
    "Movie:Romance",
    "Movie:War/Western/History",
    "Movie:Mystery/Crime",
    "Movie:Comedy",
    "Movie:Kids/Family"
  ],
  6 => [
    "Sport:Undefined",
    "Sport:AFL",
    "Sport:TrackandPool",
    "Sport:Court Sports",
    "Sport:BoxandWrest",
    "Sport:Cricket",
    "Sport:Baseball",
    "Sport:Extreme",
    "Sport:Winter",
    "Sport:Golf",
    "Sport:Racing",
    "Sport:NewsandOther",
    "Sport:Rugby League",
    "Sport:Rugby Union",
    "Sport:Soccer",
    "Sport:Special"
    ],
  8 => [
    "News and Documentaries:Undefined",
    "News and Documentaries:Business/Finance",
    "News and Documentaries:International",
    "News and Documentaries:Local",
    "News and Documentaries:Magazine/Discussion/Interview",
    "News and Documentaries:Public Affairs/Political",
    "News and Documentaries:Weather/Information",
    "News and Documentaries:Sports",
    "News and Documentaries:Biography",
    "News and Documentaries:PeopleandCulture",
    "News and Documentaries:History",
    "News and Documentaries:Science/Technology",
    "News and Documentaries: Natural World",
    "News and Documentaries:TravelandAdventure"
    ],
  10 => [
    "Kids and Family:Undefined",
    "Kids and Family:Adventure/Action",
    "Kids and Family:Animation/Cartoon",
    "Kids and Family:Comedy",
    "Kids and Family:Drama",
    "Kids and Family:Educational",
    "Kids and Family:Fantasy",
    "Kids and Family:Game Show",
    "Kids and Family:Movies",
    "Kids and Family:Musical",
    "Kids and Family:Pre-School",
    "Kids and Family:Sport",
    "Kids and Family:Science",
    "Kids and Family:Technology",
    "Kids and Family:Reality"
    ],
  12 => [
    "Music and Radio:Undefined",
    "Music and Radio:Favourites",
    "Music and Radio:Classical/Opera",
    "Music and Radio:Country",
    "Music and Radio:Dance/Techno",
    "Music and Radio:Reality/Fact",
    "Music and Radio:Jazz/Blues",
    "Music and Radio:Pop",
    "Music and Radio:Live/Request",
    "Music and Radio:RapandHip Hop",
    "Music and Radio:Rock",
    "Music and Radio:Soul/RandB",
    "Music and Radio:Radio",
    "Music and Radio:Specials"
    ],
  14 => [
    "Special Interest:Undefined",
    "Special Interest:Religion",
    "Special Interest:Foreign Language Channels",
    "Special Interest:Adult",
    "Special Interest:Shopping",
    "Special Interest:Help"
    ],
  7 => [
    "Active:Undefined",
    "Active:News and Doco",
    "Active:Sports",
    "Active:Kids and Family",
    "Active:Entertainment",
    "Active:Music and Radio",
    "Active:Arts and Leisure",
    "Active:Movies",
    "Active:Specialist",
    "Active:Services",
    "Active:Shopping",
    "Active:Help/Cust Care",
    "Active:Wagering",
    "Active:Messaging",
    "Active:Games",
    "Active:Voting/Surveys"
    ],
  5 => [
    "Games:Undefined",
    "Games:Arcade",
    "Games:Puzzle",
    "Games:Quiz",
    "Games:Multiplayer",
    "Games:Play-along",
    "Games:Sports",
    "Games:Racing",
    "Games:Kids",
    "Games:Adult"
    ],
  15 => [
    "Adult:Undefined",
    "Adult:Erotica",
    "Adult:OnDemand"
  ]
}

WARNINGS = {
  'base' => {
    "a"  => 'Adult Themes',
    "d"  => 'Drug Use',
    "h"  => 'Horror',
    "l"  => 'Language',
    "m"  => 'Mature Themes',
    "n"  => 'Nudity',
    "s"  => 'Sex',
    "v"  => 'Violence',
    "w"  => 'War Themes',
    "t"  => 'Themes',
    "st" => 'Supernatural Themes',
    "ab" => 'Animal Butchery',
    "du" => 'Drug Use',
    "dr" => 'Drug References',
    "ss" => 'Sex Scenes',
    "sr" => 'Sexual References',
    "ds" => 'Dangerous Stunts',
    "hv" => 'Hunting Violence',
    "mp" => 'Medical PRocedures',
    "o"  => 'Other'      
  },
  'C'     => ['', 0],
  'G'     => ['', 1],
  'PG'    => ['', 2],
  'M'     => ['', 3],
  'MA15+' => ['Strong ', 4],
  'R18+'  => ['High Impact ', 5]
}
