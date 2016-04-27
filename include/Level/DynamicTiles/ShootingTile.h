#pragma once

#include "global.h"
#include "Level/LevelDynamicTile.h"
#include "Structs/SpellData.h"

class ShootingTile : public virtual LevelDynamicTile {
public:
	ShootingTile(LevelScreen* levelScreen);

	void init() override;
	void loadAnimation(int skinNr) override;
	void onHit(Spell* spell) override;
	void update(const sf::Time& frameTime) override;

private:
	void loadSpells(int skinNr);

private:
	// animation time of "Active"
	sf::Time m_activeTime = sf::Time::Zero;
	sf::Time m_remainingActiveTime = sf::Time::Zero;
	// cooldown for the next spell
	sf::Time m_cooldown = sf::Time::Zero;
	sf::Time m_remainingCooldown = sf::Time::Zero;
	SpellData m_spellData;
};