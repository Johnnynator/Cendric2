#include "Level/DynamicTiles/LeverTile.h"
#include "Spells/Spell.h"
#include "Level/LevelMainCharacter.h"
#include "GameObjectComponents/InteractComponent.h"
#include "Registrar.h"

REGISTER_LEVEL_DYNAMIC_TILE(LevelDynamicTileID::Lever, LeverTile)

const float LeverTile::ACTIVATE_RANGE = 80.f;

LeverTile::LeverTile(LevelScreen* levelScreen) : LevelDynamicTile(levelScreen) {
	InteractComponent* interactComponent = new InteractComponent(g_textProvider->getText("Lever"), this, m_mainChar);
	interactComponent->setInteractRange(ACTIVATE_RANGE);
	interactComponent->setInteractText("ToSwitch");
	interactComponent->setOnInteract(std::bind(&LeverTile::switchLever, this));
	addComponent(interactComponent);
}

bool LeverTile::init(const LevelTileProperties& properties) {
	setSpriteOffset(sf::Vector2f(0.f, 0.f));
	setBoundingBox(sf::FloatRect(0.f, 0.f, TILE_SIZE_F, TILE_SIZE_F));
	return true;
}

void LeverTile::loadAnimation(int skinNr) {
	const sf::Texture* tex = g_resourceManager->getTexture(getSpritePath());

	Animation* onAnimation = new Animation(sf::seconds(10.0f));
	onAnimation->setSpriteSheet(tex);
	onAnimation->addFrame(sf::IntRect(
		BORDER,
		BORDER + skinNr * (2 * BORDER + TILE_SIZE),
		TILE_SIZE,
		TILE_SIZE));

	addAnimation(GameObjectState::On, onAnimation);

	Animation* offAnimation = new Animation(sf::seconds(10.0f));
	offAnimation->setSpriteSheet(tex);
	offAnimation->addFrame(sf::IntRect(
		BORDER + (2 * BORDER + TILE_SIZE),
		BORDER + skinNr * (2 * BORDER + TILE_SIZE),
		TILE_SIZE,
		TILE_SIZE));

	addAnimation(GameObjectState::Off, offAnimation);

	// initial values
	setState(GameObjectState::Off);
	playCurrentAnimation(false);
}

void LeverTile::onHit(Spell* spell) {
	switch (spell->getSpellID()) {
	case SpellID::Telekinesis:
		switchLever();
		spell->setDisposed();
		break;
	default:
		break;
	}
}

void LeverTile::onRightClick() {
	if (m_mainChar->isDead()) return;
	// check if lever is in range
	if (dist(m_mainChar->getCenter(), getCenter()) <= ACTIVATE_RANGE) {
		switchLever();
	}
	else {
		m_screen->setNegativeTooltip("OutOfRange");
	}
	g_inputController->lockAction();
}

void LeverTile::setDependentTiles(const std::vector<LeverDependentTile*>& dependentTiles) {
	m_dependentTiles = dependentTiles;
}

void LeverTile::switchLever() {
	for (auto& tile : m_dependentTiles) {
		if (!tile->isSwitchable()) {
			m_screen->setNegativeTooltip("LeverStuck");
			return;
		}
	}

	(m_state == GameObjectState::On) ? 
		setState(GameObjectState::Off) : 
		setState(GameObjectState::On);

	g_resourceManager->playSound(getSoundPath());

	for (auto& tile : m_dependentTiles) {
		tile->switchTile();
	}
}

std::string LeverTile::getSpritePath() const {
	return "res/assets/level_dynamic_tiles/spritesheet_tiles_lever.png";
}

std::string LeverTile::getSoundPath() const {
	return "res/sound/tile/lever_click.ogg";
}