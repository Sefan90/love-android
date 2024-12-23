heroInfo = {}
heroInfo.__index = heroInfo

function heroInfo:new()
    local self = {}
	setmetatable(self,heroInfo)
	self.h = {}
	self.h["arakni"] = {}
	self.h["arakni"].text = "Whenever you play a card with contract, you may look at the top card of target opponent's deck. You may put it on the bottom."
	self.h["arakni"].life = 20
	self.h["arakni"].CC, self.h["arakni"].CCQuad = loadImg("arakni.jpg",0,height/12) 
	self.h["arakni"].altCC = false self.h["arakni"].altCCQuad = false
	self.h["arakni"].blitz, self.h["arakni"].blitzQuad = loadImg("arakni_young.jpg",0,height/10)
	self.h["arakni"].altBlitz = false self.h["arakni"].altBlitzQuad = false
	self.h["arakni"].LLBlitz = false self.h["arakni"].LLCC = false self.h["arakni"].SpecialPromo = false self.h["arakni"].Common = true

	-- self.h["arakniChaos"] = {}
	-- self.h["arakniChaos"].text = "???"
	-- self.h["arakniChaos"].life = 20
	-- self.h["arakniChaos"].CC, self.h["arakniChaos"].CCQuad = loadImg("arakniChaos.jpg",0,height/12) 
	-- self.h["arakniChaos"].altCC = false self.h["arakniChaos"].altCCQuad = false
	-- self.h["arakniChaos"].blitz = false self.h["arakniChaos"].blitzQuad = false
	-- self.h["arakniChaos"].altBlitz = false self.h["arakniChaos"].altBlitzQuad = false
	-- self.h["arakniChaos"].LLBlitz = false self.h["arakniChaos"].LLCC = false self.h["arakniChaos"].SpecialPromo = false self.h["arakniChaos"].Common = true

	-- self.h["arakniSliped"] = {}
	-- self.h["arakniSliped"].text = "The first attack with stealth each turn gets go again."
	-- self.h["arakniSliped"].life = 19
	-- self.h["arakniSliped"].CC, self.h["arakniSliped"].CCQuad = loadImg("arakniSliped.jpg",0,height/12) 
	-- self.h["arakniSliped"].altCC = false self.h["arakniSliped"].altCCQuad = false
	-- self.h["arakniSliped"].blitz = false self.h["arakniSliped"].blitzQuad = false
	-- self.h["arakniSliped"].altBlitz = false self.h["arakniSliped"].altBlitzQuad = false
	-- self.h["arakniSliped"].LLBlitz = false self.h["arakniSliped"].LLCC = false self.h["arakniSliped"].SpecialPromo = false self.h["arakniSliped"].Common = true

	self.h["arakniSol"] = {}
	self.h["arakniSol"].text = "Your first attack with stealth each turn has go again."
	self.h["arakniSol"].life = 19
	self.h["arakniSol"].CC = false self.h["arakniSol"].CCQuad = false
	self.h["arakniSol"].altCC = false self.h["arakniSol"].altCCQuad = false
	self.h["arakniSol"].blitz, self.h["arakniSol"].blitzQuad = loadImg("arakniSol_young.jpg",0,height/15)
	self.h["arakniSol"].altBlitz = false self.h["arakniSol"].altBlitzQuad = false
	self.h["arakniSol"].LLBlitz = false self.h["arakniSol"].LLCC = false self.h["arakniSol"].SpecialPromo = false self.h["arakniSol"].Common = true

	self.h["aurora"] = {}
	self.h["aurora"].text = "Once per Turn Instant - {r}{r}: Create an Embodiment of Lightning token. Activate this only if you've played a Lightning card this turn.\nEssence of Lightning"
	self.h["aurora"].life = 20
	self.h["aurora"].CC, self.h["aurora"].CCQuad = loadImg("aurora.jpg",0,height/10) 
	self.h["aurora"].altCC = false self.h["aurora"].altCCQuad = false 
	self.h["aurora"].blitz, self.h["aurora"].blitzQuad = loadImg("aurora_young.jpg",0,height/10) 
	self.h["aurora"].altBlitz, self.h["aurora"].altBlitzQuad = loadImg("aurora_young_alt.jpg",0,height/10) 
	self.h["aurora"].LLBlitz = false self.h["aurora"].LLCC = false self.h["aurora"].SpecialPromo = false self.h["aurora"].Common = true
		
	self.h["azalea"] = {}
	self.h["azalea"].text = "Once per Turn Action - 0: Put a card from your arsenal on the bottom of your deck. If you do, put the top card of your deck face up into your arsenal. If it's an arrow card, it gains dominate until end of turn. Go again"
	self.h["azalea"].life = 20
	self.h["azalea"].CC, self.h["azalea"].CCQuad = loadImg("azalea.jpg",0,0)
	self.h["azalea"].altCC = false self.h["azalea"].altCCQuad = false
	self.h["azalea"].blitz, self.h["azalea"].blitzQuad = loadImg("azalea_young.jpg",0,-height/40) 
	self.h["azalea"].altBlitz = false self.h["azalea"].altBlitzQuad = false
	self.h["azalea"].LLBlitz = false self.h["azalea"].LLCC = false self.h["azalea"].SpecialPromo = false self.h["azalea"].Common = true

	self.h["benji"] = {}
	self.h["benji"].text = "Your attack action cards with 2 or less {p} can't be defended by cards from hand.\nThe first time an attack action card you control hits each turn, your next attack gains +1{p}."
	self.h["benji"].life = 17
	self.h["benji"].CC = false self.h["benji"].CCQuad = false
	self.h["benji"].altCC = false self.h["benji"].altCCQuad = false 
	self.h["benji"].blitz, self.h["benji"].blitzQuad = loadImg("benji_young.jpg",0,height/20)
	self.h["benji"].altBlitz = false self.h["benji"].altBlitzQuad = false
	self.h["benji"].LLBlitz = false self.h["benji"].LLCC = fals self.h["benji"].SpecialPromo = false self.h["benji"].Common = true

	self.h["betsy"] = {}
	self.h["betsy"].text = "Whenever an attack you control wagers, you may pay {r}{r}. If you do, the attack gets +1{p} and overpower."
	self.h["betsy"].life = 20
	self.h["betsy"].CC, self.h["betsy"].CCQuad = loadImg("betsy.jpg",0,0)
	self.h["betsy"].altCC = false self.h["betsy"].altCCQuad = false
	self.h["betsy"].blitz, self.h["betsy"].blitzQuad = loadImg("betsy_young.jpg",0,height/30)
	self.h["betsy"].altBlitz = false self.h["betsy"].altBlitzQuad = false
	self.h["betsy"].LLBlitz = false self.h["betsy"].LLCC = false self.h["betsy"].SpecialPromo = false self.h["betsy"].Common = true

	self.h["blaze"] = {}
	self.h["blaze"].text = "Whenever you opt, put energy counters on Blaze equal to the number of cards looked at this way.\nOnce per Turn Instant - Remove X energy counters from Blaze: Banish a Wizard non-attack action card from your hand with an effect that deals arcane damage equal to X. You may play it this turn as though it were an instant."
	self.h["blaze"].life = 17
	self.h["blaze"].CC = false self.h["blaze"].CCQuad = false
	self.h["blaze"].altCC = false self.h["blaze"].altCCQuad = false 
	self.h["blaze"].blitz, self.h["blaze"].blitzQuad = loadImg("blaze_young.jpg",0,0)
	self.h["blaze"].altBlitz = false self.h["blaze"].altBlitzQuad = false
	self.h["blaze"].LLBlitz = false self.h["blaze"].LLCC = fals self.h["blaze"].SpecialPromo = false self.h["blaze"].Common = true

	self.h["boltyn"] = {}
	self.h["boltyn"].text = "If you've charged this turn, attacks you control have +1{p} while defended by an attack action card.\nAttack Reaction - Banish a card from Boltyn's soul: Target attack with {p} greater than its base {p} gains go again."
	self.h["boltyn"].life = 20
	self.h["boltyn"].CC, self.h["boltyn"].CCQuad = loadImg("boltyn.jpg",0,0)
	self.h["boltyn"].altCC = false self.h["boltyn"].altCCQuad = false
	self.h["boltyn"].blitz, self.h["boltyn"].blitzQuad = loadImg("boltyn_young.jpg",0,0)
	self.h["boltyn"].altBlitz = false self.h["boltyn"].altBlitzQuad = false
	self.h["boltyn"].LLBlitz = false self.h["boltyn"].LLCC = false self.h["boltyn"].SpecialPromo = false self.h["boltyn"].Common = true

	self.h["bravo"] = {}
	self.h["bravo"].text = "Action - {r}{r}: Until end of turn, your attack action cards with cost 3 or greater gains dominate. Go again"
	self.h["bravo"].life = 20
	self.h["bravo"].CC, self.h["bravo"].CCQuad = loadImg("bravo.jpg",0,0)
	self.h["bravo"].altCC = false self.h["bravo"].altCCQuad = false 
	self.h["bravo"].blitz, self.h["bravo"].blitzQuad = loadImg("bravo_young.jpg",0,height/20) 
	self.h["bravo"].altBlitz = false self.h["bravo"].altBlitzQuad = false
	self.h["bravo"].LLBlitz = false self.h["bravo"].LLCC = false self.h["bravo"].SpecialPromo = false self.h["bravo"].Common = true

	self.h["bravoEVR"] = {}
	self.h["bravoEVR"].text = "Essence of Earth, Ice, and Lightning.\nAt the start of your turn, you may reveal an Earth, an Ice, and a Lightning card from your hand. If you do, the next attack action card with cost 3 or greater you play this turn gains +2{p}, dominate, and go again."
	self.h["bravoEVR"].life = 20
	self.h["bravoEVR"].CC, self.h["bravoEVR"].CCQuad = loadImg("bravoEVR.jpg",0,height/20)
	self.h["bravoEVR"].altCC = false self.h["bravoEVR"].altCCQuad = false 
	self.h["bravoEVR"].blitz = false self.h["bravoEVR"].blitzQuad = false 
	self.h["bravoEVR"].altBlitz = false self.h["bravoEVR"].altBlitzQuad = false
	self.h["bravoEVR"].LLBlitz = false self.h["bravoEVR"].LLCC = true self.h["bravoEVR"].SpecialPromo = false self.h["bravoEVR"].Common = false

	self.h["brevant"] = {}
	self.h["brevant"].text = "You may have any number of Chivalry in your deck.\nWhenever you protect another hero, create a Might token."
	self.h["brevant"].life = 20
	self.h["brevant"].CC = false self.h["brevant"].CCQuad = false
	self.h["brevant"].altCC = false self.h["brevant"].altCCQuad = false 
	self.h["brevant"].blitz, self.h["brevant"].blitzQuad = loadImg("brevant_young.jpg",0,height/20) 
	self.h["brevant"].altBlitz = false self.h["brevant"].altBlitzQuad = false
	self.h["brevant"].LLBlitz = false self.h["brevant"].LLCC = false self.h["brevant"].SpecialPromo = false self.h["brevant"].Common = false

	self.h["briar"] = {}
	self.h["briar"].text = "Essence of Earth and Lightning.\nThe first time an attack action card you control deals damage to an opposing hero, create an Embodiment of Earth token.\nWhenever you play your second 'non-attack' action card each turn, create an Embodiment of Lightning token."
	self.h["briar"].life = 20
	self.h["briar"].CC, self.h["briar"].CCQuad = loadImg("briar.jpg",0,0)
	self.h["briar"].altCC = false self.h["briar"].altCCQuad = false 
	self.h["briar"].blitz, self.h["briar"].blitzQuad = loadImg("briar_young.jpg",0,0) 
	self.h["briar"].altBlitz = false self.h["briar"].altBlitzQuad = false
	self.h["briar"].LLBlitz = false self.h["briar"].LLCC = true self.h["briar"].SpecialPromo = false self.h["briar"].Common = true

	self.h["brutus"] = {}
	self.h["brutus"].text = "You may have cards with clash of any class or talent in your deck.\nIf all heroes in a clash would fail to win, instead choose which hero wins the clash."
	self.h["brutus"].life = 20
	self.h["brutus"].CC = false self.h["brutus"].CCQuad = false
	self.h["brutus"].altCC = false self.h["brutus"].altCCQuad = false 
	self.h["brutus"].blitz, self.h["brutus"].blitzQuad = loadImg("brutus_young.jpg",0,height/20) 
	self.h["brutus"].altBlitz = false self.h["brutus"].altBlitzQuad = false
	self.h["brutus"].LLBlitz = false self.h["brutus"].LLCC = false self.h["brutus"].SpecialPromo = true self.h["brutus"].Common = false

	self.h["chane"] = {}
	self.h["chane"].text = "Once per Turn Action - Create a Soul Shackle token: Your next Runeblade or Shadow action this turn gains go again. Go again"
	self.h["chane"].life = 20
	self.h["chane"].CC, self.h["chane"].CCQuad = loadImg("chane.jpg",0,0)
	self.h["chane"].altCC = false self.h["chane"].altCCQuad = false 
	self.h["chane"].blitz, self.h["chane"].blitzQuad = loadImg("chane_young.jpg",0,height/10) 
	self.h["chane"].altBlitz = false self.h["chane"].altBlitzQuad = false
	self.h["chane"].LLBlitz = true self.h["chane"].LLCC = true self.h["chane"].SpecialPromo = false self.h["chane"].Common = true

	-- self.h["cindra"] = {}
	-- self.h["cindra"].text = "???"
	-- self.h["cindra"].life = 20
	-- self.h["cindra"].CC, self.h["cindra"].CCQuad = loadImg("cindra.jpg",0,height/10)
	-- self.h["cindra"].altCC = false self.h["cindra"].altCCQuad = false 
	-- self.h["cindra"].blitz, self.h["cindra"].blitzQuad = loadImg("cindra_young.jpg",0,height/10) 
	-- self.h["cindra"].altBlitz = false self.h["cindra"].altBlitzQuad = false
	-- self.h["cindra"].LLBlitz = false self.h["cindra"].LLCC = false self.h["cindra"].SpecialPromo = false self.h["cindra"].Common = true

	self.h["dash"] = {}
	self.h["dash"].text = "You may start the game with a Mechanologist item with cost 2 or less in the arena."
	self.h["dash"].life = 20
	self.h["dash"].CC, self.h["dash"].CCQuad = loadImg("dash.jpg",0,height/10)
	self.h["dash"].altCC = false self.h["dash"].altCCQuad = false 
	self.h["dash"].blitz, self.h["dash"].blitzQuad = loadImg("dash_young.jpg",0,height/10) 
	self.h["dash"].altBlitz = false self.h["dash"].altBlitzQuad = false
	self.h["dash"].LLBlitz = false self.h["dash"].LLCC = false self.h["dash"].SpecialPromo = false self.h["dash"].Common = true

	self.h["dashIO"] = {}
	self.h["dashIO"].text = "You may look at the top card of your deck at any time.\nOnce per turn, you may play a Mechanologist item with cost 0 or 1 from the top of your deck as though it were an instant. It costs an additional {r} to play."
	self.h["dashIO"].life = 18
	self.h["dashIO"].CC, self.h["dashIO"].CCQuad = loadImg("dashIO.jpg",0,height/20)
	self.h["dashIO"].altCC = false self.h["dashIO"].altCCQuad = false 
	self.h["dashIO"].blitz, self.h["dashIO"].blitzQuad = loadImg("dashIO_young.jpg",0,height/15) 
	self.h["dashIO"].altBlitz = false self.h["dashIO"].altBlitzQuad = false
	self.h["dashIO"].LLBlitz = false self.h["dashIO"].LLCC = false self.h["dashIO"].SpecialPromo = false self.h["dashIO"].Common = true

	self.h["datadoll"] = {}
	self.h["datadoll"].text = "Whenever a Mechanologist item with cost 2 or less is put into your banished zone from your deck, put it into the arena."
	self.h["datadoll"].life = 20
	self.h["datadoll"].CC = false self.h["datadoll"].CCQuad = false
	self.h["datadoll"].altCC = false self.h["datadoll"].altCCQuad = false 
	self.h["datadoll"].blitz, self.h["datadoll"].blitzQuad = loadImg("datadoll_young.jpg",0,height/10) 
	self.h["datadoll"].altBlitz = false self.h["datadoll"].altBlitzQuad = false
	self.h["datadoll"].LLBlitz = false self.h["datadoll"].LLCC = false self.h["datadoll"].SpecialPromo = false self.h["datadoll"].Common = true

	self.h["dori"] = {}
	self.h["dori"].text = "Once per turn Effect - When a weapon you control hits, you may attack an additional time with that weapon this turn."
	self.h["dori"].life = 20
	self.h["dori"].CC, self.h["dori"].CCQuad = loadImg("dori.jpg",0,0)
	self.h["dori"].altCC, self.h["dori"].altCCQuad = loadImg("dori_promo.jpg",0,height/20)
	self.h["dori"].blitz, self.h["dori"].blitzQuad = loadImg("dori_young.jpg",0,0) 
	self.h["dori"].altBlitz = false self.h["dori"].altBlitzQuad = false
	self.h["dori"].LLBlitz = false self.h["dori"].LLCC = false self.h["dori"].SpecialPromo = false self.h["dori"].Common = true

	self.h["doriRVD"] = {}
	self.h["doriRVD"].text = "The first time Dawnblade, Resplendent gains go again each turn, you may attack an additional time with it this turn."
	self.h["doriRVD"].life = 20
	self.h["doriRVD"].CC = false self.h["doriRVD"].CCQuad = false
	self.h["doriRVD"].altCC = false self.h["doriRVD"].altCCQuad = false 
	self.h["doriRVD"].blitz, self.h["doriRVD"].blitzQuad = loadImg("doriRVD_young.jpg",0,height/10) 
	self.h["doriRVD"].altBlitz = false self.h["doriRVD"].altBlitzQuad = false
	self.h["doriRVD"].LLBlitz = false self.h["doriRVD"].LLCC = false self.h["doriRVD"].SpecialPromo = false self.h["doriRVD"].Common = false

	self.h["dromai"] = {}
	self.h["dromai"].text = "Whenever you pitch a red card, create an Ash Token.\nIf you've played a red card this turn, dragons you control have go again while attacking."
	self.h["dromai"].life = 20
	self.h["dromai"].CC, self.h["dromai"].CCQuad = loadImg("dromai.jpg",0,height/20)
	self.h["dromai"].altCC = false self.h["dromai"].altCCQuad = false 
	self.h["dromai"].blitz, self.h["dromai"].blitzQuad = loadImg("dromai_young.jpg",0,0) 
	self.h["dromai"].altBlitz = false self.h["dromai"].altBlitzQuad = false
	self.h["dromai"].LLBlitz = false self.h["dromai"].LLCC = true self.h["dromai"].SpecialPromo = false self.h["dromai"].Common = true

	self.h["enigma"] = {}
	self.h["enigma"].text = "Your first Spectral Shield attack each turn costs {r} less to activate.\nOnce per Turn Instant - {c}{c}{c}: Create a Spectral Shield token with a +1{p} counter."
	self.h["enigma"].life = 20
	self.h["enigma"].CC, self.h["enigma"].CCQuad = loadImg("enigma.jpg",0,height/10)
	self.h["enigma"].altCC, self.h["enigma"].altCCQuad = loadImg("enigma_promo.jpg",0,height/10)
	self.h["enigma"].blitz, self.h["enigma"].blitzQuad = loadImg("enigma_young.jpg",0,height/15) 
	self.h["enigma"].altBlitz = false self.h["enigma"].altBlitzQuad = false
	self.h["enigma"].LLBlitz = false self.h["enigma"].LLCC = false self.h["enigma"].SpecialPromo = false self.h["enigma"].Common = true

	self.h["enigmaNM"] = {}
	self.h["enigmaNM"].text = "Equipment you own gets cloaked\nInstant - {c}{c}{c}, Turn target face-down equipment you have equipped face-up. If it has ward, create 3 Spectral Shield tokens."
	self.h["enigmaNM"].life = 20
	self.h["enigmaNM"].CC = false self.h["enigmaNM"].CCQuad = false
	self.h["enigmaNM"].altCC = false self.h["enigmaNM"].altCCQuad = false 
	self.h["enigmaNM"].blitz, self.h["enigmaNM"].blitzQuad = loadImg("enigmaNM_young.jpg",0,height/10) 
	self.h["enigmaNM"].altBlitz = false self.h["enigmaNM"].altBlitzQuad = false
	self.h["enigmaNM"].LLBlitz = false self.h["enigmaNM"].LLCC = false self.h["enigmaNM"].SpecialPromo = false self.h["enigmaNM"].Common = false

	self.h["emperor"] = {}
	self.h["emperor"].text = "You may only have red cards in your deck.\nAction - {r}{r}{r}: Search your deck for Command and Conquer, attack with it, then shuffle."
	self.h["emperor"].life = 15
	self.h["emperor"].CC = false self.h["emperor"].CCQuad = false
	self.h["emperor"].altCC = false self.h["emperor"].altCCQuad = false 
	self.h["emperor"].blitz, self.h["emperor"].blitzQuad = loadImg("emperor_young.jpg",0,0) 
	self.h["emperor"].altBlitz = false self.h["emperor"].altBlitzQuad = false
	self.h["emperor"].LLBlitz = false self.h["emperor"].LLCC = false self.h["emperor"].SpecialPromo = false self.h["emperor"].Common = false

	self.h["fai"] = {}
	self.h["fai"].text = "You may start the game with a Phoenix Flame in your graveyard.\nOnce per Turn Instant - {r}{r}{r}: Return a Phoenix Flame from your graveyard to your hand. This ability costs {r} less for each Draconic chain link you control."
	self.h["fai"].life = 20
	self.h["fai"].CC, self.h["fai"].CCQuad = loadImg("fai.jpg",0,height/20)
	self.h["fai"].altCC = false self.h["fai"].altCCQuad = false 
	self.h["fai"].blitz, self.h["fai"].blitzQuad = loadImg("fai_young.jpg",0,0) 
	self.h["fai"].altBlitz = false self.h["fai"].altBlitzQuad = false
	self.h["fai"].LLBlitz = false self.h["fai"].LLCC = false self.h["fai"].SpecialPromo = false self.h["fai"].Common = true

	-- self.h["fang"] = {}
	-- self.h["fang"].text = "???"
	-- self.h["fang"].life = 20
	-- self.h["fang"].CC, self.h["fang"].CCQuad = loadImg("fang.jpg",0,height/15)
	-- self.h["fang"].altCC = false self.h["fang"].altCCQuad = false 
	-- self.h["fang"].blitz, self.h["fang"].blitzQuad = loadImg("fang_young.jpg",0,height/10) 
	-- self.h["fang"].altBlitz = false self.h["fang"].altBlitzQuad = false
	-- self.h["fang"].LLBlitz = false self.h["fang"].LLCC = false self.h["fang"].SpecialPromo = false self.h["fang"].Common = true

	self.h["florian"] = {}
	self.h["florian"].text = 'If there are 4 or more Earth cards in your banished zone, Florian gets "If you would create 1 or more aura tokens, instead create that many plus 1 of each of those tokens."\nEssence of Earth'
	self.h["florian"].CCtext = 'If there are 8 or more Earth cards in your banished zone, Florian gets "If you would create 1 or more aura tokens, instead create that many plus 1 of each of those tokens."\nEssence of Earth'
	self.h["florian"].life = 20
	self.h["florian"].CC, self.h["florian"].CCQuad = loadImg("florian.jpg",0,height/10) 
	self.h["florian"].altCC = false self.h["florian"].altCCQuad = false 
	self.h["florian"].blitz, self.h["florian"].blitzQuad = loadImg("florian_young.jpg",0,height/10) 
	self.h["florian"].altBlitz = false self.h["florian"].altBlitzQuad = false
	self.h["florian"].LLBlitz = false self.h["florian"].LLCC = false self.h["florian"].SpecialPromo = false self.h["florian"].Common = true

	self.h["genis"] = {}
	self.h["genis"].text = "Once per Turn Action - {r}{r}: Each other hero may put a card from their hand on the bottom of their deck. If they do, they draw a card and you create a Silver token. If you gain no Silver this way, draw a card. Go again"
	self.h["genis"].life = 20
	self.h["genis"].CC = false self.h["genis"].CCQuad = false
	self.h["genis"].altCC = false self.h["genis"].altCCQuad = false 
	self.h["genis"].blitz, self.h["genis"].blitzQuad = loadImg("genis_young.jpg",0,0) 
	self.h["genis"].altBlitz = false self.h["genis"].altBlitzQuad = false
	self.h["genis"].LLBlitz = false self.h["genis"].LLCC = false self.h["genis"].SpecialPromo = false self.h["genis"].Common = false

	self.h["ira"] = {}
	self.h["ira"].text = "Your second attack each turn gets +1{p}."
	self.h["ira"].life = 20
	self.h["ira"].CC, self.h["ira"].CCQuad = loadImg("ira.jpg",0,0) 
	self.h["ira"].altCC, self.h["ira"].altCCQuad = loadImg("ira_promo.jpg",0,height/20) 
	self.h["ira"].blitz, self.h["ira"].blitzQuad = loadImg("ira_young.jpg",0,0) 
	self.h["ira"].altBlitz = false self.h["ira"].altBlitzQuad = false
	self.h["ira"].LLBlitz = true self.h["ira"].LLCC = false self.h["ira"].SpecialPromo = false self.h["ira"].Common = true

	self.h["iyslander"] = {}
	self.h["iyslander"].text = "Essence of Ice.\nIf it's not your turn, you may play blue 'non-attack' action cards from your arsenal as though they were an instant.\nWhenever you play an Ice card during an opponents turn, create a Frostbite token under their control."
	self.h["iyslander"].life = 18
	self.h["iyslander"].CC, self.h["iyslander"].CCQuad = loadImg("iyslander.jpg",0,height/10)
	self.h["iyslander"].altCC = false self.h["iyslander"].altCCQuad = false 
	self.h["iyslander"].blitz, self.h["iyslander"].blitzQuad = loadImg("iyslander_young.jpg",0,height/10) 
	self.h["iyslander"].altBlitz, self.h["iyslander"].altBlitzQuad = loadImg("isylander_young_alt.jpg",0,-height/20)
	self.h["iyslander"].LLBlitz = true self.h["iyslander"].LLCC = true self.h["iyslander"].SpecialPromo = false self.h["iyslander"].Common = true 

	self.h["jarl"] = {}
	self.h["jarl"].text = "Whenever you play an Ice card, create a Frostbite token in an opponent's exposed head, chest, arms, or legs zone.\nEssence of Earth and Ice"
	self.h["jarl"].life = 20
	self.h["jarl"].CC, self.h["jarl"].CCQuad = loadImg("jarl.jpg",0,height/10)
	self.h["jarl"].altCC = false self.h["jarl"].altCCQuad = false 
	self.h["jarl"].blitz = false self.h["jarl"].blitzQuad = false 
	self.h["jarl"].altBlitz = false self.h["jarl"].altBlitzQuad = false
	self.h["jarl"].LLBlitz = false self.h["jarl"].LLCC = false self.h["jarl"].SpecialPromo = false self.h["jarl"].Common = false

	self.h["kano"] = {}
	self.h["kano"].text = "Instant - {r}{r}{r}: Look at the top card of your deck. If it's a 'non-attack' action card, you may banish it. If you do, you may play it this turn as though it were an instant."
	self.h["kano"].life = 15
	self.h["kano"].CC, self.h["kano"].CCQuad = loadImg("kano.jpg",0,height/10)
	self.h["kano"].altCC = false self.h["kano"].altCCQuad = false 
	self.h["kano"].blitz, self.h["kano"].blitzQuad = loadImg("kano_young.jpg",0,0) 
	self.h["kano"].altBlitz = false self.h["kano"].altBlitzQuad = false
	self.h["kano"].LLBlitz = true self.h["kano"].LLCC = false self.h["kano"].SpecialPromo = false self.h["kano"].Common = true

	self.h["kassai"] = {}
	self.h["kassai"].text = "Your second sword attack each turn costs {r} less.\nAt the beginning of your end phase, if you have attacked 2 or more times with weapons this turn, create a Copper token for each weapon attack that hit."
	self.h["kassai"].life = 20
	self.h["kassai"].CC = false self.h["kassai"].CCQuad = false
	self.h["kassai"].altCC = false self.h["kassai"].altCCQuad = false 
	self.h["kassai"].blitz, self.h["kassai"].blitzQuad = loadImg("kassai_young.jpg",0,0) 
	self.h["kassai"].altBlitz = false self.h["kassai"].altBlitzQuad = false
	self.h["kassai"].LLBlitz = true self.h["kassai"].LLCC = false self.h["kassai"].SpecialPromo = false self.h["kassai"].Common = true

	self.h["kassaiHVY"] = {}
	self.h["kassaiHVY"].text = "If you've drawn a card this turn, your sword attacks cost {r} less to activate.\nOnce per Turn Action - Banish 2 red and 2 yellow cards from your graveyard: The next time a weapon you control hits a hero this turn, create a Gold token. Go again"
	self.h["kassaiHVY"].life = 20
	self.h["kassaiHVY"].CC, self.h["kassaiHVY"].CCQuad = loadImg("kassaiHVY.jpg",0,0)
	self.h["kassaiHVY"].altCC = false self.h["kassaiHVY"].altCCQuad = false 
	self.h["kassaiHVY"].blitz, self.h["kassaiHVY"].blitzQuad = loadImg("kassaiHVY_young.jpg",0,height/40) 
	self.h["kassaiHVY"].altBlitz = false self.h["kassaiHVY"].altBlitzQuad = false
	self.h["kassaiHVY"].LLBlitz = false self.h["kassaiHVY"].LLCC = false self.h["kassaiHVY"].SpecialPromo = false self.h["kassaiHVY"].Common = true

	self.h["katsu"] = {}
	self.h["katsu"].text = "The first time an attack action card you control hits each turn, you may discard a card with cost 0. If you do, search your deck for a card with combo, banish it face up, then shuffle your deck. You may play it this turn."
	self.h["katsu"].life = 20
	self.h["katsu"].CC, self.h["katsu"].CCQuad = loadImg("katsu.jpg",0,0)
	self.h["katsu"].altCC = false self.h["katsu"].altCCQuad = false 
	self.h["katsu"].blitz, self.h["katsu"].blitzQuad = loadImg("katsu_young.jpg",0,0) 
	self.h["katsu"].altBlitz = false self.h["katsu"].altBlitzQuad = false
	self.h["katsu"].LLBlitz = false self.h["katsu"].LLCC = false self.h["katsu"].SpecialPromo = false self.h["katsu"].Common = true

	self.h["kavdaen"] = {}
	self.h["kavdaen"].text = "Once per Turn Action - {r}{r}{r}: If a hero has more {h} than all other hero's, they lose 1{h} and create a Copper token. Then if a hero has less {h} than all other hero's, they gain 1{h}. Go again"
	self.h["kavdaen"].life = 20
	self.h["kavdaen"].CC = false self.h["kavdaen"].CCQuad = false
	self.h["kavdaen"].altCC = false self.h["kavdaen"].altCCQuad = false 
	self.h["kavdaen"].blitz, self.h["kavdaen"].blitzQuad = loadImg("kavdaen_young.jpg",0,0) 
	self.h["kavdaen"].altBlitz = false self.h["kavdaen"].altBlitzQuad = false
	self.h["kavdaen"].LLBlitz = false self.h["kavdaen"].LLCC = false self.h["kavdaen"].SpecialPromo = false self.h["kavdaen"].Common = true

	self.h["kayo"] = {}
	self.h["kayo"].text = "Whenever you play an attack action card with base power 6 or more {p}, roll a 6 sided die. On;\n1 to 4 - Halve the attack's base {p}, rounded down.\n5 to 6 - Double the attack's base {p}."
	self.h["kayo"].life = 19
	self.h["kayo"].CC = false self.h["kayo"].CCQuad = false
	self.h["kayo"].altCC = false self.h["kayo"].altCCQuad = false 
	self.h["kayo"].blitz, self.h["kayo"].blitzQuad = loadImg("kayo_young.jpg",0,height/20) 
	self.h["kayo"].altBlitz = false self.h["kayo"].altBlitzQuad = false
	self.h["kayo"].LLBlitz = false self.h["kayo"].LLCC = false self.h["kayo"].SpecialPromo = false self.h["kayo"].Common = true

	self.h["kayoHVY"] = {}
	self.h["kayoHVY"].text = "You have 1 weapon zone.\nAttack action cards you own get +1{p} while they are in any zone other than the combat chain.\nThe first time you discard a card with 6 or more {p} during each of your action phases, create a Might token."
	self.h["kayoHVY"].life = 20
	self.h["kayoHVY"].CC, self.h["kayoHVY"].CCQuad = loadImg("kayoHVY.jpg",0,height/10)
	self.h["kayoHVY"].altCC = false self.h["kayoHVY"].altCCQuad = false 
	self.h["kayoHVY"].blitz, self.h["kayoHVY"].blitzQuad = loadImg("kayoHVY_young.jpg",0,height/20) 
	self.h["kayoHVY"].altBlitz = false self.h["kayoHVY"].altBlitzQuad = false
	self.h["kayoHVY"].LLBlitz = false self.h["kayoHVY"].LLCC = false self.h["kayoHVY"].SpecialPromo = false self.h["kayoHVY"].Common = true

	self.h["levia"] = {}
	self.h["levia"].text = "If a card with 6 or more {p} has been put into your banished zone this turn, cards you own lose blood debt during the end phase."
	self.h["levia"].life = 20
	self.h["levia"].CC, self.h["levia"].CCQuad = loadImg("levia.jpg",0,0)
	self.h["levia"].altCC = false self.h["levia"].altCCQuad = false 
	self.h["levia"].blitz, self.h["levia"].blitzQuad = loadImg("levia_young.jpg",0,0) 
	self.h["levia"].altBlitz = false self.h["levia"].altBlitzQuad = false
	self.h["levia"].LLBlitz = false self.h["levia"].LLCC = false self.h["levia"].SpecialPromo = false self.h["levia"].Common = true

	self.h["lexi"] = {}
	self.h["lexi"].text = "Essence of Ice and Lightning.\nOnce per Turn Action - Turn a face down card in your arsenal face up: If it's a Lightning card, your next attack this turn gains go again. If it's an Ice card, create a Frostbite token under target hero's control. Go again"
	self.h["lexi"].life = 20
	self.h["lexi"].CC, self.h["lexi"].CCQuad = loadImg("lexi.jpg",0,0)
	self.h["lexi"].altCC = false self.h["lexi"].altCCQuad = false 
	self.h["lexi"].blitz, self.h["lexi"].blitzQuad = loadImg("lexi_young.jpg",0,height/10) 
	self.h["lexi"].altBlitz = false self.h["lexi"].altBlitzQuad = false
	self.h["lexi"].LLBlitz = false self.h["lexi"].LLCC = true self.h["lexi"].SpecialPromo = false self.h["lexi"].Common = true

	self.h["maxx"] = {}
	self.h["maxx"].text = "Once per Turn Action - {r}{r}: Create a Hyper Driver token with 2 steam counters. Activate this ability only if you've boosted this turn.\nHyper Drivers you control get Crank."
	self.h["maxx"].life = 20
	self.h["maxx"].CC, self.h["maxx"].CCQuad = loadImg("maxx.jpg",0,height/10)
	self.h["maxx"].altCC = false self.h["maxx"].altCCQuad = false 
	self.h["maxx"].blitz, self.h["maxx"].blitzQuad = loadImg("maxx_young.jpg",0,height/15) 
	self.h["maxx"].altBlitz = false self.h["maxx"].altBlitzQuad = false
	self.h["maxx"].LLBlitz = false self.h["maxx"].LLCC = false self.h["maxx"].SpecialPromo = false self.h["maxx"].Common = true

	self.h["melody"] = {}
	self.h["melody"].text = "Whenever you play a song, create Copper tokens equal to the number of other heroes in the game."
	self.h["melody"].life = 20
	self.h["melody"].CC = false self.h["melody"].CCQuad = false
	self.h["melody"].altCC = false self.h["melody"].altCCQuad = false 
	self.h["melody"].blitz, self.h["melody"].blitzQuad = loadImg("melody_young.jpg",0,height/20) 
	self.h["melody"].altBlitz = false self.h["melody"].altBlitzQuad = false
	self.h["melody"].LLBlitz = false self.h["melody"].LLCC = false self.h["melody"].SpecialPromo = false self.h["melody"].Common = false

	self.h["nuu"] = {}
	self.h["nuu"].text = "Your attacks with stealth get \"When this chain link resolves, banish all action cards defending this.\"\nInstant - {c}{c}{c}: Look at the top card of an opposing hero's deck. If it's blue, you may banish it. Until end of turn, you may play blue cards from that hero's banished zone without paying their {r} cost."
	self.h["nuu"].life = 20
	self.h["nuu"].CC, self.h["nuu"].CCQuad = loadImg("nuu.jpg",0,height/10)
	self.h["nuu"].altCC, self.h["nuu"].altCCQuad = loadImg("nuu_promo.jpg",0,0)
	self.h["nuu"].blitz, self.h["nuu"].blitzQuad = loadImg("nuu_young.jpg",0,height/20) 
	self.h["nuu"].altBlitz = false self.h["nuu"].altBlitzQuad = false
	self.h["nuu"].LLBlitz = false self.h["nuu"].LLCC = false self.h["nuu"].SpecialPromo = false self.h["nuu"].Common = true

	self.h["oldhim"] = {}
	self.h["oldhim"].text = "Essence of Earth and Ice.\nOnce per Turn Defense Reaction - {r}{r}{r}: If an Earth card is pitched this way, prevent the next 2 damage that would be dealt to Oldhim this turn. If an Ice card is pitched this way, the attacking hero puts a card from their hand on top of their deck."
	self.h["oldhim"].life = 20
	self.h["oldhim"].CC, self.h["oldhim"].CCQuad = loadImg("oldhim.jpg",0,0)
	self.h["oldhim"].altCC = false self.h["oldhim"].altCCQuad = false 
	self.h["oldhim"].blitz, self.h["oldhim"].blitzQuad = loadImg("oldhim_young.jpg",0,height/10) 
	self.h["oldhim"].altBlitz = false self.h["oldhim"].altBlitzQuad = false
	self.h["oldhim"].LLBlitz = true self.h["oldhim"].LLCC = true self.h["oldhim"].SpecialPromo = false self.h["oldhim"].Common = true

	self.h["olympia"] = {}
	self.h["olympia"].text = "The first time each of your attacks wins a wager, create a Gold token."
	self.h["olympia"].life = 20
	self.h["olympia"].CC, self.h["olympia"].CCQuad = loadImg("olympia.jpg",0,height/10)
	self.h["olympia"].altCC = false self.h["olympia"].altCCQuad = false 
	self.h["olympia"].blitz, self.h["olympia"].blitzQuad = loadImg("olympia_young.jpg",0,height/30) 
	self.h["olympia"].altBlitz = false self.h["olympia"].altBlitzQuad = false
	self.h["olympia"].LLBlitz = false self.h["olympia"].LLCC = false self.h["olympia"].SpecialPromo = false self.h["olympia"].Common = true

	self.h["oscilio"] = {}
	self.h["oscilio"].text = "Once per Turn Instant - Discard an instant: Draw a card.\nEssence of Lightning"
	self.h["oscilio"].life = 18
	self.h["oscilio"].CC, self.h["oscilio"].CCQuad = loadImg("oscilio.jpg",0,height/12) 
	self.h["oscilio"].altCC = false self.h["oscilio"].altCCQuad = false 
	self.h["oscilio"].blitz, self.h["oscilio"].blitzQuad = loadImg("oscilio_young.jpg",0,height/15) 
	self.h["oscilio"].altBlitz = false self.h["oscilio"].altBlitzQuad = false
	self.h["oscilio"].LLBlitz = false self.h["oscilio"].LLCC = false self.h["oscilio"].SpecialPromo = false self.h["oscilio"].Common = true

	self.h["prism"] = {}
	self.h["prism"].text = "Once per Turn Instant - {r}{r}, banish a card from Prism's soul: Create a Spectral Shield token."
	self.h["prism"].life = 20
	self.h["prism"].CC, self.h["prism"].CCQuad = loadImg("prism.jpg",0,0)
	self.h["prism"].altCC = false self.h["prism"].altCCQuad = false 
	self.h["prism"].blitz, self.h["prism"].blitzQuad = loadImg("prism_young.jpg",0,0) 
	self.h["prism"].altBlitz = false self.h["prism"].altBlitzQuad = false
	self.h["prism"].LLBlitz = false self.h["prism"].LLCC = true self.h["prism"].SpecialPromo = false self.h["prism"].Common = true

	self.h["prismDTD"] = {}
	self.h["prismDTD"].text = "Whenever a card with Herald in its name is put into Prism's soul during an action phase, you may search your deck for a figment, put it into the arena, then shuffle.\nOnce per Turn Instant - {r}{r}, banish a card from Prism's soul: Awaken target figment you control."
	self.h["prismDTD"].life = 16
	self.h["prismDTD"].CC, self.h["prismDTD"].CCQuad = loadImg("prismDTD.jpg",0,0)
	self.h["prismDTD"].altCC = false self.h["prismDTD"].altCCQuad = false 
	self.h["prismDTD"].blitz, self.h["prismDTD"].blitzQuad = loadImg("prismDTD_young.jpg",0,0) 
	self.h["prismDTD"].altBlitz = false self.h["prismDTD"].altBlitzQuad = false
	self.h["prismDTD"].LLBlitz = false self.h["prismDTD"].LLCC = false self.h["prismDTD"].SpecialPromo = false self.h["prismDTD"].Common = false

	self.h["professor"] = {}
	self.h["professor"].text = "Evos cost {r} less to play for each opposing hero.\nYou may play Evos from your banished zone."
	self.h["professor"].life = 20
	self.h["professor"].CC = false self.h["professor"].CCQuad = false
	self.h["professor"].altCC = false self.h["professor"].altCCQuad = false 
	self.h["professor"].blitz, self.h["professor"].blitzQuad = loadImg("professor_young.jpg",0,height/20) 
	self.h["professor"].altBlitz = false self.h["professor"].altBlitzQuad = false
	self.h["professor"].LLBlitz = false self.h["professor"].LLCC = false self.h["professor"].SpecialPromo = false self.h["professor"].Common = false

	self.h["rhinar"] = {}
	self.h["rhinar"].text = "Whenever you discard a card with 6 or more {p} during your action phase, intimidate."
	self.h["rhinar"].life = 20
	self.h["rhinar"].CC, self.h["rhinar"].CCQuad = loadImg("rhinar.jpg",0,height/20)
	self.h["rhinar"].altCC, self.h["rhinar"].altCCQuad = loadImg("rhinar_alt.jpg",0,height/10)
	self.h["rhinar"].blitz, self.h["rhinar"].blitzQuad = loadImg("rhinar_young.jpg",0,height/20)
	self.h["rhinar"].altBlitz, self.h["rhinar"].altBlitzQuad = loadImg("rhinar_young_alt.jpg",0,height/10) 
	self.h["rhinar"].LLBlitz = false self.h["rhinar"].LLCC = false self.h["rhinar"].SpecialPromo = false self.h["rhinar"].Common = true

	self.h["riptide"] = {}
	self.h["riptide"].text = "Whenever you play a card from hand, you may put a card from hand face down into your arsenal.\nWhenever a trap you control triggers, deal 1 damage to the attacking hero."
	self.h["riptide"].life = 19
	self.h["riptide"].CC, self.h["riptide"].CCQuad = loadImg("riptide.jpg",0,height/20)
	self.h["riptide"].altCC = false self.h["riptide"].altCCQuad = false 
	self.h["riptide"].blitz, self.h["riptide"].blitzQuad = loadImg("riptide_young.jpg",0,height/10) 
	self.h["riptide"].altBlitz = false self.h["riptide"].altBlitzQuad = false
	self.h["riptide"].LLBlitz = false self.h["riptide"].LLCC = false self.h["riptide"].SpecialPromo = false self.h["riptide"].Common = true

	self.h["shiyana"] = {}
	self.h["shiyana"].text = "You may have specialization cards of any hero in your deck.\nAt the beginning of your action phase, Shiyana becomes a copy of target hero until the start of your next turn, and gains 'Cards you own are the class of your hero in addition to their other class types.'"
	self.h["shiyana"].life = 20
	self.h["shiyana"].CC = false self.h["shiyana"].CCQuad = false
	self.h["shiyana"].altCC = false self.h["shiyana"].altCCQuad = false 
	self.h["shiyana"].blitz, self.h["shiyana"].blitzQuad = loadImg("shiyana_young.jpg",0,height/20) 
	self.h["shiyana"].altBlitz = false self.h["shiyana"].altBlitzQuad = false
	self.h["shiyana"].LLBlitz = false self.h["shiyana"].LLCC = false self.h["shiyana"].SpecialPromo = false self.h["shiyana"].Common = false

	self.h["squizzy"] = {}
	self.h["squizzy"].text = "At the start of each opposing hero's turn, they may create a Cracked Bauble in their hand. If they do, you create a Gold token."
	self.h["squizzy"].life = 20
	self.h["squizzy"].CC = false self.h["squizzy"].CCQuad = false
	self.h["squizzy"].altCC = false self.h["squizzy"].altCCQuad = false 
	self.h["squizzy"].blitz, self.h["squizzy"].blitzQuad = loadImg("squizzy_young.jpg",0,0) 
	self.h["squizzy"].altBlitz = false self.h["squizzy"].altBlitzQuad = false
	self.h["squizzy"].LLBlitz = false self.h["squizzy"].LLCC = false self.h["squizzy"].SpecialPromo = true self.h["squizzy"].Common = false

	self.h["taipanis"] = {}
	self.h["taipanis"].text = "The first time each turn another hero becomes the target of a source that would deal lethal damage, you may discard a red card. If you do, choose new targets for that source."
	self.h["taipanis"].life = 20
	self.h["taipanis"].CC = false self.h["taipanis"].CCQuad = false
	self.h["taipanis"].altCC = false self.h["taipanis"].altCCQuad = false 
	self.h["taipanis"].blitz, self.h["taipanis"].blitzQuad = loadImg("taipanis_young.jpg",0,0) 
	self.h["taipanis"].altBlitz = false self.h["taipanis"].altBlitzQuad = false
	self.h["taipanis"].LLBlitz = false self.h["taipanis"].LLCC = false self.h["taipanis"].SpecialPromo = true self.h["taipanis"].Common = false

	self.h["taylor"] = {}
	self.h["taylor"].text = "You may have equipment of any class or talent in your inventory. Each equipment in your starting inventory must have a different name.\nAt the start of your turn, you may banish an equipment you control. If you do, equip a card of the same subtype from your inventory."
	self.h["taylor"].life = 20
	self.h["taylor"].CC = false self.h["taylor"].CCQuad = false
	self.h["taylor"].altCC = false self.h["taylor"].altCCQuad = false 
	self.h["taylor"].blitz, self.h["taylor"].blitzQuad = loadImg("taylor_young.jpg",0,0) 
	self.h["taylor"].altBlitz = false self.h["taylor"].altBlitzQuad = false
	self.h["taylor"].LLBlitz = false self.h["taylor"].LLCC = false self.h["taylor"].SpecialPromo = true self.h["taylor"].Common = false

	self.h["teklovossen"] = {}
	self.h["teklovossen"].text = "You may play Evos from your banished zone.\nOnce per Turn Instant - {r}{r}{r}: You may play your next Evo this turn as though it were an instant. When you do, draw a card."
	self.h["teklovossen"].life = 20
	self.h["teklovossen"].CC, self.h["teklovossen"].CCQuad = loadImg("teklovossen.jpg",0,height/20)
	self.h["teklovossen"].altCC = false self.h["teklovossen"].altCCQuad = false 
	self.h["teklovossen"].blitz, self.h["teklovossen"].blitzQuad = loadImg("teklovossen_young.jpg",0,height/15) 
	self.h["teklovossen"].altBlitz = false self.h["teklovossen"].altBlitzQuad = false
	self.h["teklovossen"].LLBlitz = false self.h["teklovossen"].LLCC = false self.h["teklovossen"].SpecialPromo = false self.h["teklovossen"].Common = true

	self.h["terra"] = {}
	self.h["terra"].text = "At the beginning of each end phase, if there is an Earth card in your pitch zone, you may pay {r}. If you do, create a Might token.\nEssence of Earth"
	self.h["terra"].life = 20
	self.h["terra"].CC = false self.h["terra"].CCQuad = false
	self.h["terra"].altCC = false self.h["terra"].altCCQuad = false 
	self.h["terra"].blitz, self.h["terra"].blitzQuad = loadImg("terra_young.jpg",0,height/10) 
	self.h["terra"].altBlitz = false self.h["terra"].altBlitzQuad = false
	self.h["terra"].LLBlitz = false self.h["terra"].LLCC = false self.h["terra"].SpecialPromo = false self.h["terra"].Common = false

	self.h["theryon"] = {}
	self.h["theryon"].text = "The first time each turn another hero destroys a card they don’t control, you may pay {r}{r}. If you do, they destroy a non-hero permanent they control."
	self.h["theryon"].life = 20
	self.h["theryon"].CC = false self.h["theryon"].CCQuad = false
	self.h["theryon"].altCC = false self.h["theryon"].altCCQuad = false 
	self.h["theryon"].blitz, self.h["theryon"].blitzQuad = loadImg("theryon_young.jpg",0,0) 
	self.h["theryon"].altBlitz = false self.h["theryon"].altBlitzQuad = false
	self.h["theryon"].LLBlitz = false self.h["theryon"].LLCC = false self.h["theryon"].SpecialPromo = true self.h["theryon"].Common = false

	self.h["uzuri"] = {}
	self.h["uzuri"].text = "Once per Turn Attack Reaction - Banish a card from your hand face down: Turn the card banished this way face up. If it's an attack action card with cost 2 or less, put target attacking card with stealth from the active chain link on the bottom of its owner's deck, then put the banished card onto the active chain link as the attacking card."
	self.h["uzuri"].life = 20
	self.h["uzuri"].CC, self.h["uzuri"].CCQuad = loadImg("uzuri.jpg",0,height/10)
	self.h["uzuri"].altCC = false self.h["uzuri"].altCCQuad = false 
	self.h["uzuri"].blitz, self.h["uzuri"].blitzQuad = loadImg("uzuri_young.jpg",0,height/40) 
	self.h["uzuri"].altBlitz = false self.h["uzuri"].altBlitzQuad = false
	self.h["uzuri"].LLBlitz = false self.h["uzuri"].LLCC = false self.h["uzuri"].SpecialPromo = false self.h["uzuri"].Common = true

	self.h["valda"] = {}
	self.h["valda"].text = "Whenever an opponent draws a card during an action phase, create a Seismic Surge token for each card drawn this way.\nAt the start of your turn, if you control 3 or more Seismic Surge tokens, cards you own with crush gain dominate this turn."
	self.h["valda"].life = 21
	self.h["valda"].CC = false self.h["valda"].CCQuad = false
	self.h["valda"].altCC = false self.h["valda"].altCCQuad = false 
	self.h["valda"].blitz, self.h["valda"].blitzQuad = loadImg("valda_young.jpg",0,0) 
	self.h["valda"].altBlitz = false self.h["valda"].altBlitzQuad = false
	self.h["valda"].LLBlitz = false self.h["valda"].LLCC = false self.h["valda"].SpecialPromo = false self.h["valda"].Common = false

	self.h["verdance"] = {}
	self.h["verdance"].text = "If there are 4 or more Earth cards in your banished zone, Verdance gets \"Whenever you gain {h} during your turn, you may deal 1 arcane damage to any opposing target.\"\nEssence of Earth"
	self.h["verdance"].CCtext = "If there are 8 or more Earth cards in your banished zone, Verdance gets \"Whenever you gain {h} during your turn, you may deal 1 arcane damage to any opposing target.\"\nEssence of Earth"
	self.h["verdance"].life = 20
	self.h["verdance"].CC, self.h["verdance"].CCQuad = loadImg("verdance.jpg",0,height/10) 
	self.h["verdance"].altCC = false self.h["verdance"].altCCQuad = false 
	self.h["verdance"].blitz, self.h["verdance"].blitzQuad = loadImg("verdance_young.jpg",0,height/10) 
	self.h["verdance"].altBlitz = false self.h["verdance"].altBlitzQuad = false
	self.h["verdance"].LLBlitz = false self.h["verdance"].LLCC = false self.h["verdance"].SpecialPromo = false self.h["verdance"].Common = true

	self.h["victor"] = {}
	self.h["victor"].text = "The first time each turn you create a Gold token from an effect you control, draw a card.\nThe first time each turn you would fail to win a clash, instead you may destroy a Gold you control. If you do, put 1 of the revealed cards on the bottom of its owner's deck, then clash again."
	self.h["victor"].life = 20
	self.h["victor"].CC, self.h["victor"].CCQuad = loadImg("victor.jpg",0,height/15)
	self.h["victor"].altCC = false self.h["victor"].altCCQuad = false 
	self.h["victor"].blitz, self.h["victor"].blitzQuad = loadImg("victor_young.jpg",0,height/30) 
	self.h["victor"].altBlitz = false self.h["victor"].altBlitzQuad = false
	self.h["victor"].LLBlitz = false self.h["victor"].LLCC = false self.h["victor"].SpecialPromo = false self.h["victor"].Common = true

	self.h["viserai"] = {}
	self.h["viserai"].text = "Whenever you play a Runeblade card, if you have played another 'non-attack' action card this turn, create a Runechant token."
	self.h["viserai"].life = 20
	self.h["viserai"].CC, self.h["viserai"].CCQuad = loadImg("viserai.jpg",0,height/20)
	self.h["viserai"].altCC, self.h["viserai"].altCCQuad = loadImg("viserai_promo.jpg",0,height/20)
	self.h["viserai"].blitz, self.h["viserai"].blitzQuad = loadImg("viserai_young.jpg",0,0) 
	self.h["viserai"].altBlitz = false self.h["viserai"].altBlitzQuad = false
	self.h["viserai"].LLBlitz = true self.h["viserai"].LLCC = false self.h["viserai"].SpecialPromo = false self.h["viserai"].Common = true

	self.h["vynnset"] = {}
	self.h["vynnset"].text = "At the start of your turn, banish a card from your hand. If you do, create a Runechant token.\nWhenever you play a Shadow non-attack action card, you may pay {h}. If you do, the next Runechant effect that would deal damage this turn can't be prevented."
	self.h["vynnset"].life = 20
	self.h["vynnset"].CC, self.h["vynnset"].CCQuad = loadImg("vynnset.jpg",0,height/20)
	self.h["vynnset"].altCC = false self.h["vynnset"].altCCQuad = false 
	self.h["vynnset"].blitz, self.h["vynnset"].blitzQuad = loadImg("vynnset_young.jpg",0,0) 
	self.h["vynnset"].altBlitz = false self.h["vynnset"].altBlitzQuad = false
	self.h["vynnset"].LLBlitz = false self.h["vynnset"].LLCC = false self.h["vynnset"].SpecialPromo = false self.h["vynnset"].Common = true

	self.h["yoji"] = {}
	self.h["yoji"].text = "Once per Turn Instant - {r}{r}{r}: The next time another target hero would be dealt damage this turn, instead that damage is dealt to Yoji and prevent 1 of that damage."
	self.h["yoji"].life = 22
	self.h["yoji"].CC = false self.h["yoji"].CCQuad = false
	self.h["yoji"].altCC = false self.h["yoji"].altCCQuad = false 
	self.h["yoji"].blitz, self.h["yoji"].blitzQuad = loadImg("yoji_young.jpg",0,0) 
	self.h["yoji"].altBlitz = false self.h["yoji"].altBlitzQuad = false
	self.h["yoji"].LLBlitz = false self.h["yoji"].LLCC = false self.h["yoji"].SpecialPromo = false self.h["yoji"].Common = false

	self.h["yorick"] = {}
	self.h["yorick"].text = "At the start of the game, all heroes shuffle their starting decks together. All heroes share the same deck and graveyard this game."
	self.h["yorick"].life = 20
	self.h["yorick"].CC = false self.h["yorick"].CCQuad = false
	self.h["yorick"].altCC = false self.h["yorick"].altCCQuad = false 
	self.h["yorick"].blitz, self.h["yorick"].blitzQuad = loadImg("yorick_young.jpg",0,0) 
	self.h["yorick"].altBlitz = false self.h["yorick"].altBlitzQuad = false
	self.h["yorick"].LLBlitz = false self.h["yorick"].LLCC = false self.h["yorick"].SpecialPromo = true self.h["yorick"].Common = false

	self.h["zen"] = {}
	self.h["zen"].text = "Once per Turn Instant - {c}{c}{c}: Create a Crouching Tiger in your hand. Search your deck for a card with combo, banish it, then shuffle. You may play it this turn."
	self.h["zen"].life = 20
	self.h["zen"].CC, self.h["zen"].CCQuad = loadImg("zen.jpg",0,height/15)
	self.h["zen"].altCC = false self.h["zen"].altCCQuad = false 
	self.h["zen"].blitz, self.h["zen"].blitzQuad = loadImg("zen_young.jpg",0,height/15) 
	self.h["zen"].altBlitz = false self.h["zen"].altBlitzQuad = false
	self.h["zen"].LLBlitz = false self.h["zen"].LLCC = false self.h["zen"].SpecialPromo = false self.h["zen"].Common = true

    return self
end

function heroInfo:getText(hero,ifCC)
	if ifCC == true and self.h[hero].CCtext then
		return self.h[hero].CCtext
	end
	return self.h[hero].text
end

function heroInfo:getInfo(BlitzOrCC, getLL, getPromo, onlyCommon, heroList)
	local image, alt, imageQuad, altQuad, life = {}, {}, {}, {}, {}
	local tkeys = {}
	-- populate the table that holds the keys
	if heroList ~= nil then
		tkeys = heroList
	else
		for k in pairs(self.h) do table.insert(tkeys, k) end
	end
	-- sort the keys
	table.sort(tkeys)

	for _,k in pairs(tkeys) do
		if (self.h[k].SpecialPromo == false or self.h[k].SpecialPromo == getPromo) and (self.h[k].Common == true or self.h[k].Common == onlyCommon) then
			if BlitzOrCC == "blitz" then
				if self.h[k].LLBlitz == false or self.h[k].LLBlitz == getLL then
					if self.h[k].blitz ~= false then
						table.insert(image, {k,self.h[k].blitz})
						table.insert(alt, {k,self.h[k].altBlitz})
						table.insert(imageQuad, {k,self.h[k].blitzQuad})
						table.insert(altQuad, {k,self.h[k].altBlitzQuad})
						table.insert(life, {k,self.h[k].life})
					end
				end
			else
				if self.h[k].LLCC == false or self.h[k].LLCC == getLL then
					if self.h[k].CC ~= false then
						table.insert(image, {k,self.h[k].CC})
						table.insert(alt, {k,self.h[k].altCC})
						table.insert(imageQuad, {k,self.h[k].CCQuad})
						table.insert(altQuad, {k,self.h[k].altCCQuad})
						table.insert(life, {k,self.h[k].life*2})
					end
				end
			end
		end
	end
	return image, alt, imageQuad, altQuad, life
end