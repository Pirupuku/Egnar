
-- inRange = CheckInteractDistance("unit", distIndex);
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards

local path = "Interface\\Icons\\"
local warriorHelper
local mageHelper
local rogueHelper
local warlockHelper
local shamanHelper
local shamanHelper2
local paladinHelper
local priestHelper
local hunterHelper
local druidHelper

function Egnar_OnLoad()
  Egnar_Frame:Hide()
  _, cl = UnitClass("player")
  --if cl ~= "HUNTER" then
    --DEFAULT_CHAT_FRAME:AddMessage("Egnar is only for hunters")
    --return
 -- end
  FontString1:SetTextColor(1, 1, 1)

  this:RegisterEvent("PLAYER_TARGET_CHANGED")
  this:RegisterEvent("UNIT_FACTION")

  this:SetScript("OnEvent", Egnar_OnEvent)
  this:SetScript("OnUpdate", Egnar_OnUpdate)

  this:RegisterForDrag("LeftButton")
  this:SetScript("OnDragStart", function()
    this:StartMoving()
  end)
  this:SetScript("OnDragStop", function()
    this:StopMovingOrSizing()
  end)

  DEFAULT_CHAT_FRAME:AddMessage("Egnar Loaded")
end

function SetColor(r, g, b, a)
  Egnar_Frame:SetBackdropColor(r, g, b, a)
  Egnar_Frame:SetBackdropBorderColor(r, g, b, a)
end

function Egnar_OnUpdate()
	_, cl = UnitClass("player")
	
	if cl == "WARRIOR" then
		for i = 1, 120 do
			texture = GetActionTexture(i)
			if not GetActionText(i) and texture ~= nil then
				if (texture == path.."Spell_Nature_BloodLust" or texture == path.."INV_Shield_05" or texture == path.."Ability_Rogue_Ambush" or texture == path.."Ability_Warrior_Cleave" or texture == path.."Ability_Warrior_SavageBlow" or texture == path.."Ability_ShockWave") then
					if IsActionInRange(i) == 1 then
						FontString1:SetText("Melee")
						SetColor(unpack({0, 1, 0, 0.7}))
						warriorHelper = 1
					else
						warriorHelper = 0
					end
				elseif (texture == path.."Ability_Throw" or texture == path.."Ability_Marksmanship") and warriorHelper == 0 then
						if IsActionInRange(i) == 1 then
							if CheckInteractDistance("target", 4) then
								FontString1:SetText("In Range")
								SetColor(unpack({0, 0.5, 1, 0.7}))
							else
								FontString1:SetText("Long Range")
								SetColor(unpack({0, 0, 1, 0.7}))
							end
						elseif CheckInteractDistance("target", 4) then
							FontString1:SetText("Dead Zone")
							SetColor(unpack({1, 0.5, 0, 0.7}))
						else
							FontString1:SetText("Out of Range")
							SetColor(unpack({1, 0, 0, 0.7}))
						end
				end
			end
		end
	end
	
	if cl == "MAGE" then
		-- talent check for range
		local _,_,_,_,currentRankFrost = GetTalentInfo(3, 11)
		local _,_,_,_,currentRankFire = GetTalentInfo(2, 4)
		if currentRankFrost > currentRankFire then
			mageHelper = 0
		else
			mageHelper = 1
		end
		for j = 1, 120 do
			texture = GetActionTexture(j)
			if not GetActionText(j) and texture ~= nil then
				if CheckInteractDistance("target", 3) then
					FontString1:SetText("Close Range")
					SetColor(unpack({0, 1, 0, 0.7}))
				elseif ((texture == path.."Spell_Fire_FlameBolt" and mageHelper == 1) or (texture == path.."Spell_Frost_FrostBolt02" and mageHelper == 0)) then
					if IsActionInRange(j) == 1 then
							if CheckInteractDistance("target", 4) then
								FontString1:SetText("In Range")
								SetColor(unpack({0, 0.5, 1, 0.7}))		
							elseif (texture == path.."Spell_Nature_Polymorph" or texture == path.."Spell_Nature_StarFall" or texture == path.."Spell_Holy_MagicalSentry" or texture == path.."Ability_ShootWand") then
								FontString1:SetText("Long Range")
								SetColor(unpack({0.5, 0, 1, 0.7}))
							else
								FontString1:SetText("Extra Long Range")
								SetColor(unpack({0, 0, 1, 0.7}))
							end
					else
						FontString1:SetText("Out of Range")
						SetColor(unpack({1, 0, 0, 0.7}))
					end
				end
			end
		end
	end
	
	if cl == "ROGUE" then
		for k = 1, 120 do
			texture = GetActionTexture(k)
			if not GetActionText(k) and texture ~= nil then
					if (texture == path.."Spell_Shadow_RitualOfSacrifice" or texture == path.."Ability_BackStab" or texture == path.."Ability_Rogue_Ambush" or texture == path.."Ability_Sap" or texture == path.."Ability_Rogue_Eviscerate" or texture == path.."Ability_CheapShot" or texture == path.."Ability_Rogue_Garrote" or texture == path.."Ability_Rogue_KidneyShot") then
						if IsActionInRange(k) == 1 then
							FontString1:SetText("Melee")
							SetColor(unpack({0, 1, 0, 0.7}))
							rogueHelper = 1
						else
							rogueHelper = 0
						end
					elseif (texture == path.."Ability_Throw" or texture == path.."Ability_Marksmanship") and rogueHelper == 0 then
							if IsActionInRange(k) == 1 then
								if CheckInteractDistance("target", 4) then
									FontString1:SetText("In Range")
									SetColor(unpack({0, 0.5, 1, 0.7}))
								else
									FontString1:SetText("Long Range")
									SetColor(unpack({0, 0, 1, 0.7}))
								end
							elseif CheckInteractDistance("target", 4) then
								FontString1:SetText("Dead Zone")
								SetColor(unpack({1, 0.5, 0, 0.7}))
							else
								FontString1:SetText("Out of Range")
								SetColor(unpack({1, 0, 0, 0.7}))
							end
					end
			end
		end
	end
	
	if cl == "HUNTER" then
		for l = 1, 120 do
			texture = GetActionTexture(l)
			if not GetActionText(l) and texture ~= nil then
				if (texture == path.."Ability_Rogue_Trip" or texture == path.."Ability_Hunter_SwiftStrike") then
					if IsActionInRange(l) == 1 then
						FontString1:SetText("Melee")
						SetColor(unpack({0, 1, 0, 0.7}))
						hunterHelper = 1
					else
						hunterHelper = 0
					end
				elseif (texture == path.."INV_Weapon_Crossbow_06" or texture == path.."Ability_ImpalingBolt" or texture == path.."INV_Spear_07" or texture == path.."Ability_UpgradeMoonGlaive") and hunterHelper == 0 then
						if IsActionInRange(l) == 1 then
							if CheckInteractDistance("target", 4) then
								FontString1:SetText("In Range")
								SetColor(unpack({0, 0.5, 1, 0.7}))
							else
								FontString1:SetText("Long Range")
								SetColor(unpack({0, 0, 1, 0.7}))
							end
						elseif CheckInteractDistance("target", 4) then
							FontString1:SetText("Dead Zone")
							SetColor(unpack({1, 0.5, 0, 0.7}))
						else
							FontString1:SetText("Out of Range")
							SetColor(unpack({1, 0, 0, 0.7}))
						end
				end
			end
		end

	end
	
	if cl == "WARLOCK" then
		-- talent check for range
		local _,_,_,_,currentRankAffli = GetTalentInfo(1, 10)
		local _,_,_,_,currentRankShadow = GetTalentInfo(3, 10)
		if currentRankShadow > currentRankAffli then
			warlockHelper = 0
		else
			warlockHelper = 1
		end
		for m = 1, 120 do
			texture = GetActionTexture(m)
			if not GetActionText(m) and texture ~= nil then
				if CheckInteractDistance("target", 3) then
					FontString1:SetText("Close Range")
					SetColor(unpack({0, 1, 0, 0.7}))
				elseif ((texture == path.."Spell_Shadow_ShadowBolt" and warlockHelper == 0) or (texture == path.."Spell_Shadow_AbominationExplosion" and warlockHelper == 1)) then
					if IsActionInRange(m) == 1 then
							if CheckInteractDistance("target", 4) then
								FontString1:SetText("In Range")
								SetColor(unpack({0, 0.5, 1, 0.7}))		
							elseif (texture == path.."Spell_Shadow_DemonBreath" or texture == path.."Spell_Sahdow_EnslaveDemon" or texture == path.."Spell_Shadow_Cripple" or texture == path.."Ability_ShootWand") then
								FontString1:SetText("Long Range")
								SetColor(unpack({0.5, 0, 1, 0.7}))
							else
								FontString1:SetText("Extra Long Range")
								SetColor(unpack({0, 0, 1, 0.7}))
							end
					else
						FontString1:SetText("Out of Range")
						SetColor(unpack({1, 0, 0, 0.7}))
					end
				end
			end
		end
	end
	
	if cl == "PRIEST" then
		-- talent check for range
		local _,_,_,_,currentRankShadow = GetTalentInfo(3, 10)
		if currentRankShadow == 3 then
			priestHelper = 1
		else
			priestHelper = 0
		end
		for n = 1, 120 do
			texture = GetActionTexture(n)
			if not GetActionText(n) and texture ~= nil then
				if CheckInteractDistance("target", 3) then
					FontString1:SetText("Close Range")
					SetColor(unpack({0, 1, 0, 0.7}))
				elseif (texture == path.."Spell_Shadow_ShadowWordPain" or texture == path.."Spell_Shadow_UnholyFrenzy") then
					if IsActionInRange(n) == 1 then
						if CheckInteractDistance("target", 4) then
							FontString1:SetText("In Range")
							SetColor(unpack({0, 0.5, 1, 0.7}))		
						elseif (texture == path.."Spell_Holy_HolySmite" or texture == path.."Spell_Holy_DispelMagic") then
							FontString1:SetText("Long Range")
							SetColor(unpack({0.5, 0, 1, 0.7}))
						elseif (priestHelper == 1 and (texture == path.."Spell_Shadow_ShadowWordPain" or texture == path.."Spell_Shadow_UnholyFrenzy")) then
							FontString1:SetText("Extra Long Range")
							SetColor(unpack({0, 0, 1, 0.7}))
						end
					else
						FontString1:SetText("Out of Range")
						SetColor(unpack({1, 0, 0, 0.7}))
					end
				end
			end
		end
	end
	
	if cl == "PALADIN" then
		for o = 1, 120 do
			texture = GetActionTexture(o)
			if not GetActionText(o) and texture ~= nil then
				if CheckInteractDistance("target", 3) then
					FontString1:SetText("Close Range")
					SetColor(unpack({0, 1, 0, 0.7}))
				elseif (texture == path.."Spell_Holy_Excorcism_02" or texture == path.."Ability_ThunderClap") then
					if IsActionInRange(o) == 1 then
						if CheckInteractDistance("target", 4) then
							FontString1:SetText("In Range")
							SetColor(unpack({0, 0.5, 1, 0.7}))		
						else
							FontString1:SetText("Long Range")
							SetColor(unpack({0.5, 0, 1, 0.7}))
						end
					else
						FontString1:SetText("Out of Range")
						SetColor(unpack({1, 0, 0, 0.7}))
					end
				end
			end
		end
	end
	
	if cl == "SHAMAN" then
		local _,_,_,_,currentRankLight = GetTalentInfo(1, 12)
		local _,_,_,_,currentRankStrike = GetTalentInfo(2, 16)
		if currentRankLight > 0 then
			shamanHelper = 1
		elseif currentRankStrike > 0 then
			shamanHelper = 2
		else
			shamanHelper = 0
		end
		for p = 1, 120 do
			texture = GetActionTexture(p)
			if not GetActionText(p) and texture ~= nil then
				if shamanHelper == 2 then
					if (texture == path.."Spell_Holy_SealOfMight") then
						if IsActionInRange(p) == 1 then	
							FontString1:SetText("Melee")
							SetColor(unpack({0, 1, 0, 0.7}))
							shamanHelper2 = 1
						else
							shamanHelper2 = 0
						end
					elseif (texture == path.."Spell_Nature_Purge" or texture == path.."Spell_Nature_ChainLightning" or texture == path.."Spell_Nature_Lightning") and shamanHelper2 == 0 then
							if IsActionInRange(p) == 1 then
								if CheckInteractDistance("target", 4) then
									FontString1:SetText("In Range")
									SetColor(unpack({0, 0.5, 1, 0.7}))
								else
									FontString1:SetText("Long Range")
									SetColor(unpack({0, 0, 1, 0.7}))
								end
							elseif CheckInteractDistance("target", 4) then
								FontString1:SetText("Dead Zone")
								SetColor(unpack({1, 0.5, 0, 0.7}))
							else
								FontString1:SetText("Out of Range")
								SetColor(unpack({1, 0, 0, 0.7}))
							end
					end
				elseif (shamanHelper == 1 or shamanHelper == 0) then
					if CheckInteractDistance("target", 3) then
						FontString1:SetText("Close Range")
						SetColor(unpack({0, 1, 0, 0.7}))
					elseif ((texture == path.."Spell_Nature_ChainLightning" and shamanHelper == 1) or (texture == path..path.."Spell_Nature_Lightning" and shamanHelper == 1)) then
						if IsActionInRange(p) == 1 then
								if CheckInteractDistance("target", 4) then
									FontString1:SetText("In Range")
									SetColor(unpack({0, 0.5, 1, 0.7}))		
								elseif (texture == path.."Spell_Nature_Purge") then
									FontString1:SetText("Long Range")
									SetColor(unpack({0.5, 0, 1, 0.7}))
								else
									FontString1:SetText("Extra Long Range")
									SetColor(unpack({0, 0, 1, 0.7}))
								end
						else
							FontString1:SetText("Out of Range")
							SetColor(unpack({1, 0, 0, 0.7}))
						end
					elseif (texture == path.."Spell_Nature_ChainLightning" or texture == path..path.."Spell_Nature_Lightning" or texture == path.."Spell_Nature_Purge") then
						if IsActionInRange(p) == 1 then
								if CheckInteractDistance("target", 4) then
									FontString1:SetText("In Range")
									SetColor(unpack({0, 0.5, 1, 0.7}))		
								else
									FontString1:SetText("Long Range")
									SetColor(unpack({0.5, 0, 1, 0.7}))
								end
						else
							FontString1:SetText("Out of Range")
							SetColor(unpack({1, 0, 0, 0.7}))
						end
					end
				end
			end
		end
	end
	
	if cl == "DRUID" then
		for q = 1, 120 do
			texture = GetActionTexture(q)
			if not GetActionText(q) and texture ~= nil then
				if (texture == path.."INV_Misc_MonserClaw_03" or texture == path.."Spell_Shadow_VampiricAura" or texture == path.."Ability_GhoulFrenzy" or texture == path.."Ability_Druid_Disembowel" or texture == path.."Ability_Druid_SupriseAttack" or texture == path.."Ability_Druid_FerociousBite" or texture == path.."Ability_Druid_Rake" or texture == path.."Ability_Druid_Bash") then
					if IsActionInRange(q) == 1 then
						FontString1:SetText("Melee")
						SetColor(unpack({0, 1, 0, 0.7}))
						druidHelper = 1
					else
						druidHelper = 0
					end
				elseif (texture == path.."Spell_Nature_StrangleVines" or texture == path.."Spell_Nature_AbolishMagic" or texture == path.."Spell_Nature_FaerieFire" or texture == path.."Spell_Nature_StarFall" or texture == path.."Spell_Arcane_StarFire" or texture == path.."Spell_Nature_Sleep" or texture == path.."Spell_Nature_InsectSwarm") and druidHelper == 0 then
						if IsActionInRange(q) == 1 then
							if CheckInteractDistance("target", 4) then
								FontString1:SetText("In Range")
								SetColor(unpack({0, 0.5, 1, 0.7}))
							else
								FontString1:SetText("Long Range")
								SetColor(unpack({0, 0, 1, 0.7}))
							end
						elseif CheckInteractDistance("target", 4) then
							FontString1:SetText("Dead Zone")
							SetColor(unpack({1, 0.5, 0, 0.7}))
						else
							FontString1:SetText("Out of Range")
							SetColor(unpack({1, 0, 0, 0.7}))
						end
				else
				
				end
			end
		end
	end
	
end
	
function Egnar_OnEvent()
  if(UnitExists("target") and (not UnitIsDead("target")) and UnitCanAttack("player", "target")) then
    Egnar_Frame:Show()
  else
    Egnar_Frame:Hide()
  end
end
