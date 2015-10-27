#pragma once

#include "global.h"
#include "SpellCreator.h"

#include "Spells/LightSpell.h"

// a class that creates light spells
class LightSpellCreator : public SpellCreator {
public:
	LightSpellCreator(const SpellBean& spellBean, LevelMovableGameObject* owner);
	void executeSpell(const sf::Vector2f& target) override;
};