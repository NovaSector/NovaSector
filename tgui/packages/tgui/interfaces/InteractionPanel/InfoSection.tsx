// THIS IS A NOVA SECTOR UI FILE
import {
  Icon,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../backend';

type HeaderInfo = {
  isTargetSelf: boolean;
  pleasure: number;
  arousal: number;
  pain: number;
  theirPleasure: number;
  theirArousal: number;
  theirPain: number;
  arousal_limit: number;
};

export const InfoSection = () => {
  const { data } = useBackend<HeaderInfo>();
  const {
    isTargetSelf,
    pleasure,
    arousal,
    pain,
    theirPleasure,
    theirArousal,
    theirPain,
    arousal_limit
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
                    maxValue={arousal_limit}
                    color="purple">
                    <Icon name="heart" /> Pleasure
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={arousal}
                    maxValue={arousal_limit}
                    color="pink">
                    <Icon name="tint" /> Arousal
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={pain}
                    maxValue={arousal_limit} color="red">
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
                      maxValue={arousal_limit}
                      color="purple">
                      <Icon name="heart" /> Pleasure
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirArousal}
                      maxValue={arousal_limit}
                      color="pink">
                      <Icon name="tint" /> Arousal
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirPain}
                      maxValue={arousal_limit}
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
