// THIS IS A NOVA SECTOR UI FILE
import {
  Button,
  Section,
  Stack,
  LabeledList,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { BooleanLike } from 'tgui-core/react';
import { InfoSection } from './InfoSection';
import { MainContent } from './MainContent';

type Interaction = {
  self;
  use_subtler;
  erp_interaction: BooleanLike;
}

export function InteractionPanel () {
  const { act, data } = useBackend<Interaction>();
  const {
    self,
    use_subtler,
    erp_interaction,
    has_erp_interaction,
  } = data;

  return (
    <Window width={500} height={600} title={`Interact - ${self}`}>
      <Window.Content scrollable>
          {!!erp_interaction && !!has_erp_interaction && (
            <Section>
              <Stack vertical fill>
                  <Stack.Item grow>
                    <InfoSection />
                  </Stack.Item>
              </Stack>

              <LabeledList>
                <Button.Checkbox
                  checked={use_subtler}
                  onClick={() =>
                    act('toggle_subtler', {
                      use_subtler: !use_subtler,
                    })
                  }
                  tooltip="Untick to make lewd interactions visible to all mobs in range able to perceive them."
                >
                  Use Subtler
                </Button.Checkbox>
              </LabeledList>

            </Section>
          )}

          <Stack>
              <Stack.Item grow>
                <MainContent />
              </Stack.Item>
          </Stack>
      </Window.Content>
    </Window>
  );
};
