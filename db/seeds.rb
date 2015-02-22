# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Sinebrychoff", year:1897
b2 = Brewery.create name:"Malmgård", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042
b4 = Brewery.create name:"Saimaan Juomatehdas", year: 1932, active:false

Style.create name:"Lager", description:"Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base."
Style.create name:"Porter", description:"Porter is said to have been popular with transportation workers of Central London, hence the name. Most traditional British brewing documentation from the 1700s state that Porter was a blend of three different styles: an old ale (stale or soured), a new ale (brown or pale ale) and a weak one (mild ale), with various combinations of blending and staleness. The end result was also commonly known as \"Entire Butt\" or \"Three Threads\" and had a pleasing taste of neither new nor old. It was the first truly engineered beer, catering to the public's taste, playing a critical role in quenching the thirst of the UK's Industrial Revolution and lending an arm in building the mega-breweries of today. Porter saw a comeback during the homebrewing and micro-brewery revolution of the late 1970s and early 80s, in the US. Modern-day Porters are typically brewed using a pale malt base with the addition of black malt, crystal, chocolate or smoked brown malt. The addition of roasted malt is uncommon, but used occasionally. Some brewers will also age their beers after inoculation with live bacteria to create an authentic taste. Hop bitterness is moderate on the whole and color ranges from brown to black. Overall they remain very complex and interesting beers."
Style.create name:"Hefeweizen", description: "A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The \"Hefe\" prefix means \"with yeast\", hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer. Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention."
Style.create name:"Pale Ale", description:"The English Pale Ale can be traced back to the city of Burton-upon-Trent, a city with an abundance of rich hard water. This hard water helps with the clarity as well as enhancing the hop bitterness. This ale can be from golden to reddish amber in color with generally a good head retention. A mix of fruity, hoppy, earthy, buttery and malty aromas and flavors can be found. Typically all ingredients are English."

b1.beers.create name:"Iso 3", style_id:1
b1.beers.create name:"Karhu", style_id:1
b1.beers.create name:"Tuplahumala", style_id:1
b1.beers.create name:"Two Tree Porter", style_id:2
b2.beers.create name:"Huvila Pale Ale", style_id:4
b2.beers.create name:"X-Porter", style_id:2
b3.beers.create name:"Hefeweizen", style_id:3
b3.beers.create name:"Helles", style_id:1

