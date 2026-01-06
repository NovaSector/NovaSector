import {
  Icon,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

type HeaderInfo = {
  isTargetSelf: boolean;
  pleasure: number;
  maxPleasure: number;
  arousal: number;
  maxArousal: number;
  pain: number;
  maxPain: number;
  theirPleasure: number;
  theirMaxPleasure: number;
  theirArousal: number;
  theirMaxArousal: number;
  theirPain: number;
  theirMaxPain: number;
};

export const InfoSection = () => {
  const { data } = useBackend<HeaderInfo>();
  const {
    isTargetSelf,
    pleasure,
    maxPleasure,
    arousal,
    maxArousal,
    pain,
    maxPain,
    theirPleasure,
    theirMaxPleasure,
    theirArousal,
    theirMaxArousal,
    theirPain,
    theirMaxPain,
  } = data;
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack>
            <Stack.Item grow>
                You...
            </Stack.Item>
            {!isTargetSelf ? (
              <Stack.Item grow>
                  They...
              </Stack.Item>
            ) : null}
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item grow>
              <Stack vertical>
                <Stack.Item>
                  <ProgressBar
                    value={pleasure}
                    maxValue={maxPleasure}
                    color="purple">
                    <Icon name="heart" /> Pleasure
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={arousal}
                    maxValue={maxArousal}
                    color="pink">
                    <Icon name="tint" /> Arousal
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={pain}
                    maxValue={maxPain} color="red">
                    <Icon name="bolt" /> Pain
                  </ProgressBar>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            {!isTargetSelf ? (
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <ProgressBar
                      value={theirPleasure}
                      maxValue={theirMaxPleasure}
                      color="purple">
                      <Icon name="heart" /> Pleasure
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirArousal}
                      maxValue={theirMaxArousal}
                      color="pink">
                      <Icon name="tint" /> Arousal
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirPain}
                      maxValue={theirMaxPain}
                      color="red">
                      <Icon name="bolt" /> Pain
                    </ProgressBar>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ) : null}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
