#pragma once

#include <effectengine/Animation_Swirl.h>

#define ANIM_SWIRL_FAST "Rainbow swirl fast"

class Animation_SwirlFast : public Animation_Swirl
{
	Q_OBJECT

	static QJsonObject GetArgs();

public:
	Animation_SwirlFast(QString name=ANIM_SWIRL_FAST);

	static EffectDefinition getDefinition();
};
