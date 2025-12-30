import {
  Icon,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

type HeaderInfo = {
  pleasure: number;
  maxPleasure: number;
  arousal: number;
  maxArousal: number;
  pain: number;
  maxPain: number;
};

export const InfoSection = () => {
  const { act, data } = useBackend<HeaderInfo>();
  const {
    pleasure,
    maxPleasure,
    arousal,
    maxArousal,
    pain,
    maxPain,
  } = data;
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item>
          <Stack fill>
            <Stack.Item grow>
              <Stack vertical>
                <Stack.Item>
                  <ProgressBar
                    value={pleasure}
                    maxValue={maxPleasure}
                    color="purple"
                  >
                    <Icon name="heart" /> Pleasure
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={arousal}
                    maxValue={maxArousal}
                    color="pink"
                  >
                    <Icon name="tint" /> Arousal
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar value={pain} maxValue={maxPain} color="red">
                    <Icon name="bolt" /> Pain
                  </ProgressBar>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
