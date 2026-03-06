// THIS IS A NOVA SECTOR UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';

import {
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureColorInput,
  FeatureSliderInput,
  type FeatureValueProps
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';


function FeatureSecondVoiceDropdownInput(
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) {
  const { act } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_second_voice');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
}

const FeatureSecondBlooperDropdownInput = (
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
            act('play_second_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const voice_actor_color: Feature<string> = {
  name: 'Chat Color',
  component: FeatureColorInput,
};

export const voice_actor: FeatureChoiced = {
  name: 'TTS Voice',
  component: FeatureSecondVoiceDropdownInput,
};

export const voice_actor_pitch: FeatureNumeric = {
  name: 'TTS Pitch',
  component: FeatureSliderInput,
};

export const voice_actor_blooper: FeatureChoiced = {
  name: 'Vocal Bark',
  component: FeatureSecondBlooperDropdownInput,
};

export const voice_actor_blooper_speech_speed: FeatureNumeric = {
  name: 'Vocal Bark Speed',
  component: FeatureSliderInput,
};

export const voice_actor_blooper_speech_pitch: FeatureNumeric = {
  name: 'Vocal Bark Pitch',
  component: FeatureSliderInput,
};

export const voice_actor_blooper_pitch_range: FeatureNumeric = {
  name: 'Vocal Bark Range',
  component: FeatureSliderInput,
};
