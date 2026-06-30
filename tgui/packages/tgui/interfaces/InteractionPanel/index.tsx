// THIS IS A NOVA SECTOR UI FILE
import { Button, LabeledList, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { InfoSection } from './InfoSection';
import { MainContent } from './MainContent';

type SimulatedGenital = {
  name: string;
  active: BooleanLike;
};

type Interaction = {
  self;
  use_subtler;
  erp_interaction: BooleanLike;
  has_erp_interaction: BooleanLike;
  simulated_genitals?: SimulatedGenital[];
};

export function InteractionPanel() {
  const { act, data } = useBackend<Interaction>();
  const {
    self,
    use_subtler,
    erp_interaction,
    has_erp_interaction,
    simulated_genitals,
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

        {!!simulated_genitals?.length && (
          <Section title="Simulated Slots">
            <LabeledList>
              {simulated_genitals.map((slot) => (
                <Button.Checkbox
                  key={slot.name}
                  checked={!!slot.active}
                  onClick={() =>
                    act('toggle_genital_active', {
                      genital: slot.name,
                    })
                  }
                  tooltip={`Toggle ${slot.name} interactions`}
                >
                  {slot.name.charAt(0).toUpperCase() + slot.name.slice(1)}
                </Button.Checkbox>
              ))}
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
}
