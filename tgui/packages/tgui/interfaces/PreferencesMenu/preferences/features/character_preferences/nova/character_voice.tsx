import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';

import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureSliderInput,
  FeatureToggle,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = useBackend();

  return (
    <Stack g={0.5}>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const voice_type: FeatureChoiced = {
  name: 'Voice Type',
  description:
    'What kind of sound plays when your character says something in chat.',
  component: FeatureDropdownInput,
};

export const fallback_to_blooper: FeatureToggle = {
  name: 'Vocal Bark Fallback',
  description: 'If TTS is down, use vocal barks as a fallback option.',
  component: CheckboxInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Vocal Bark Range',
  description:
    '[0.1 - 0.8] Lower number, less range. Higher number, more range.',
  component: FeatureNumberInput,
};

export const blooper_speech: FeatureChoiced = {
  name: 'Vocal Bark',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speech_speed: FeatureNumeric = {
  name: 'Vocal Bark Speed',
  description:
    '[2 - 16] Lower number, faster speed. Higher number, slower voice.',
  component: FeatureNumberInput,
};

export const blooper_speech_pitch: FeatureNumeric = {
  name: 'Vocal Bark Pitch',
  description:
    '[0.4 - 2] Lower number, deeper pitch. Higher number, higher pitch.',
  component: FeatureNumberInput,
};

export const hear_sound_blooper: FeatureToggle = {
  name: 'Enable Vocal Barks',
  category: 'SOUND',
  description:
    "Alternative to TTS: When enabled, be able to hear players' vocal barks when they are speaking (including your own).",
  component: CheckboxInput,
};

export const sound_blooper_volume: Feature<number> = {
  name: 'Vocal Bark Volume',
  category: 'SOUND',
  description: 'The volume that the Vocal Barks sounds will play at.',
  component: FeatureSliderInput,
};
