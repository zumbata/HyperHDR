#include <effectengine/Animation4Music_PulseMultiSlow.h>
#include <hyperhdrbase/SoundCapture.h>

Animation4Music_PulseMultiSlow::Animation4Music_PulseMultiSlow() :
	AnimationBaseMusic(AMUSIC_PULSEMULTISLOW)	,
	_internalIndex(0),
	_oldMulti(0)
{
	
};

EffectDefinition Animation4Music_PulseMultiSlow::getDefinition()
{
	EffectDefinition ed;
	ed.name = AMUSIC_PULSEMULTISLOW;
	ed.args = GetArgs();
	return ed;
}

void Animation4Music_PulseMultiSlow::Init(
	QImage& hyperImage,
	int hyperLatchTime	
)
{		
	SetSleepTime(15);
}

bool Animation4Music_PulseMultiSlow::Play(QPainter* painter)
{
	return false;
}

bool Animation4Music_PulseMultiSlow::hasOwnImage()
{
	return true;
};

bool Animation4Music_PulseMultiSlow::getImage(Image<ColorRgb>& newImage)
{	
	bool newData = false;
	auto r = SoundCapture::getInstance()->hasResult(this, _internalIndex, NULL, &newData, NULL, &_oldMulti);	

	if (r==NULL || !newData)
		return false;

	QColor color, empty;
	uint32_t maxSingle, average;

	if (!r->GetStats(average, maxSingle, empty, NULL, &color))
		return false;
	
	int red = color.red();
	int green = color.green();
	int blue = color.blue();

	newImage.fastBox(0,0,newImage.width()-1,newImage.height()-1, red, green, blue);

	return true;
};







