-- Dialogue for NPC "npc_yasha"
loadDialogue = function(DL) 

	if (not DL:isConditionFulfilled("npc_yasha", "talked")) then 
		DL:setRoot(1) 
	elseif (not DL:isConditionFulfilled("npc_yasha", "attacked") and not (DL:isConditionFulfilled("npc_yasha", "unfriendly") or DL:isConditionFulfilled("npc_yasha", "friendly"))) then 
		DL:setRoot(2) 
	elseif (not DL:isConditionFulfilled("npc_yasha", "attacked") and not DL:isConditionFulfilled("boss", "BossYasha") and not DL:isConditionFulfilled("npc_yasha", "attacked") and not (DL:isConditionFulfilled("npc_yasha", "unfriendly") and DL:isConditionFulfilled("npc_yasha", "question"))) then 
		DL:setRoot(9) 
	elseif (DL:isConditionFulfilled("npc_yasha", "attacked") or (DL:isConditionFulfilled("npc_yasha", "unfriendly") and DL:isConditionFulfilled("npc_yasha", "question"))) then 
		DL:setRoot(13) 
	else 
		DL:setRoot(17) 
	end 

	if (not DL:isConditionFulfilled("npc_yasha", "talked")) then 

		DL:createNPCNode(1, -2, "DL_Yasha_Hi") -- (Growls) Another mortal dares to trespass into my temple. Any last words?
		DL:addConditionProgress("npc_yasha", "talked")
		DL:addNode()

	end

	if (not DL:isConditionFulfilled("npc_yasha", "attacked") and not (DL:isConditionFulfilled("npc_yasha", "unfriendly") or DL:isConditionFulfilled("npc_yasha", "friendly"))) then 

		DL:createChoiceNode(2)
		if (not DL:isConditionFulfilled("npc_yasha", "urn_open") and not DL:isConditionFulfilled("npc_yasha", "talk")) then 
			DL:addChoice(4, "DL_Choice_PeacefulTalk") -- Can we have a peaceful talk, demon?
		end
		if (DL:isConditionFulfilled("npc_yasha", "urn_open") and not DL:isConditionFulfilled("npc_yasha", "talk")) then 
			DL:addChoice(6, "DL_Choice_PeacefulTalk") -- 
		end
		DL:addChoice(3, "Choice_Yasha_Attack") -- I'm not here to talk. [ATTACK]
		DL:addChoice(-1, "DL_Yasha_End") -- (Back away slowly.)
		DL:addNode()

		if (not DL:isConditionFulfilled("npc_yasha", "urn_open") and not DL:isConditionFulfilled("npc_yasha", "talk")) then 

			DL:createNPCNode(4, 5, "DL_Yasha_YashaSanctuaryDone") -- (Yasha stares at you) Hrr. You did traverse my temple without touching my sacred urns. No human did overcome the temptation of touching them before. 
			DL:addConditionProgress("npc_yasha", "friendly")
			DL:addConditionProgress("npc_yasha", "talk")
			DL:addNode()


			DL:createNPCNode(5, -2, "DL_Yasha_YashaSanctuaryDone2") -- I will answer all of your questions, human.
			DL:changeQuestState("yasha_sanctuary", "completed")
			DL:addNode()

		end

		if (DL:isConditionFulfilled("npc_yasha", "urn_open") and not DL:isConditionFulfilled("npc_yasha", "talk")) then 

			DL:createNPCNode(6, 7, "DL_Choice_PeacefulTalkNot") -- I've seen you stomping through my temple, opening my sacred urns and destroying the peaceful atmosphere.
			DL:addConditionProgress("npc_yasha", "talk")
			DL:addConditionProgress("npc_yasha", "unfriendly")
			DL:addNode()


			DL:createNPCNode(7, -2, "DL_Choice_PeacefulTalkNot2") -- You're of the same vile kind as all humans. Before I crush your miserable existence, I grant you one question. Choose wisely. 
			DL:addNode()

		end


		DL:createNPCNode(3, 8, "DL_Yasha_Attack") -- Well, prepare to die then.
		DL:addConditionProgress("npc_yasha", "attacked")
		DL:addNode()


		DL:createNPCNode(8, -1, "") -- 
		DL:startLevel("res/level/boss_yasha/boss_yasha.tmx", 400, 810)
		DL:addNode()

	end

	if (not DL:isConditionFulfilled("npc_yasha", "attacked") and not DL:isConditionFulfilled("boss", "BossYasha") and not DL:isConditionFulfilled("npc_yasha", "attacked") and not (DL:isConditionFulfilled("npc_yasha", "unfriendly") and DL:isConditionFulfilled("npc_yasha", "question"))) then 

		DL:createChoiceNode(9)
		if (not DL:isConditionFulfilled("npc_yasha", "what_guarding")) then 
			DL:addChoice(10, "DL_Choice_WhatGuarding") -- What are you guarding?
		end
		if (not DL:isConditionFulfilled("npc_yasha", "mages")) then 
			DL:addChoice(11, "DL_Choice_Mages") -- Who did pass through here before me?
		end
		if (not DL:isConditionFulfilled("npc_yasha", "who_summoned")) then 
			DL:addChoice(12, "DL_Choice_WhoSummoned") -- Who summoned you?
		end
		if (DL:isConditionFulfilled("npc_yasha", "what_guarding") and not DL:isConditionFulfilled("npc_yasha", "secret")) then 
			DL:addChoice(15, "DL_Choice_Secret") -- What's that secret?
		end
		if (DL:isConditionFulfilled("npc_yasha", "what_guarding") and not DL:isConditionFulfilled("npc_yasha", "key")) then 
			DL:addChoice(16, "DL_Choice_Key") -- Where's that key you were guarding?
		end
		if (DL:isConditionFulfilled("npc_yasha", "friendly") and not DL:isConditionFulfilled("npc_yasha", "attackable")) then 
			DL:addChoice(18, "DL_Choice_LetPass") -- Will you let me pass through your temple?
		end
		if (DL:isConditionFulfilled("npc_yasha", "attackable")) then 
			DL:addChoice(19, "DL_Choice_LetsFight") -- Alright, I'm ready to fight. [ATTACK]
		end
		DL:addChoice(-1, "DL_Yasha_End") -- 
		DL:addNode()

		if (not DL:isConditionFulfilled("npc_yasha", "what_guarding")) then 

			DL:createNPCNode(10, -2, "DL_Yasha_WhatGuarding") -- I was guarding a key to a secret that should've never been revealed.
			DL:addConditionProgress("npc_yasha", "what_guarding")
			DL:addConditionProgress("npc_yasha", "question")
			DL:addNode()

		end

		if (not DL:isConditionFulfilled("npc_yasha", "mages")) then 

			DL:createNPCNode(11, -2, "DL_Yasha_Mages") -- A filthy thief and his henchmen. They outwit me with some magic not known to me. 
			DL:addConditionProgress("npc_yasha", "mages")
			DL:addConditionProgress("npc_yasha", "question")
			DL:addNode()

		end

		if (not DL:isConditionFulfilled("npc_yasha", "who_summoned")) then 

			DL:createNPCNode(12, -2, "DL_Yasha_WhoSummoned") -- A necromancer, a long time ago. As so many necromancers, he underestimated the powers he was playing with.
			DL:addConditionProgress("npc_yasha", "who_summoned")
			DL:addConditionProgress("npc_yasha", "question")
			DL:addNode()

		end

		if (DL:isConditionFulfilled("npc_yasha", "what_guarding") and not DL:isConditionFulfilled("npc_yasha", "secret")) then 

			DL:createNPCNode(15, -2, "DL_Yasha_Secret") -- ...
			DL:addConditionProgress("npc_yasha", "secret")
			DL:addNode()

		end

		if (DL:isConditionFulfilled("npc_yasha", "what_guarding") and not DL:isConditionFulfilled("npc_yasha", "key")) then 

			DL:createNPCNode(16, -2, "DL_Yasha_Key") -- Grr. It got stolen. But the sword will find its way back to me.
			DL:addConditionProgress("npc_yasha", "key")
			DL:addNode()

		end

		if (DL:isConditionFulfilled("npc_yasha", "friendly") and not DL:isConditionFulfilled("npc_yasha", "attackable")) then 

			DL:createNPCNode(18, -2, "DL_Yasha_LetPass") -- Hrrr. Yes, I will. But first you will have to prove that you're worthy. Fight me.
			DL:addConditionProgress("npc_yasha", "attackable")
			DL:addNode()

		end

		if (DL:isConditionFulfilled("npc_yasha", "attackable")) then 

			DL:createNPCNode(19, -1, "") -- 
			DL:startLevel("res/level/boss_yasha/boss_yasha.tmx", 400, 810)
			DL:addNode()

		end

	end

	if (DL:isConditionFulfilled("npc_yasha", "attacked") or (DL:isConditionFulfilled("npc_yasha", "unfriendly") and DL:isConditionFulfilled("npc_yasha", "question"))) then 

		DL:createNPCNode(13, 14, "DL_Yasha_DieNow") -- That's enough. Die now.
		DL:addNode()


		DL:createNPCNode(14, -1, "") -- 
		DL:startLevel("res/level/boss_yasha/boss_yasha.tmx", 400, 810)
		DL:addNode()

	end


	DL:createNPCNode(17, -1, "DL_Yasha_BeSafe") -- Be safe.
	DL:addNode()

end