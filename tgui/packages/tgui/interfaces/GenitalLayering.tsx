// THIS IS A NOVA SECTOR UI FILE
import { useBackend } from '../backend';
import { Button, NoticeBox, Section, Stack, Tabs } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { Window } from '../layouts';
type GenitalEntry = {
  name: string;
  ref: string;
};
type Data = {
  genitals: GenitalEntry[];
  selected: string | null;
  visibility: string | null;
  layering: string | null;
  custom: BooleanLike;
  visibility_options: string[];
  layering_options: string[];
};
export const GenitalLayering = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    genitals = [],
    selected,
    visibility,
    layering,
    custom,
    visibility_options = [],
    layering_options = [],
  } = data;
  return (
    <Window width={420} height={300}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Tabs>
              {genitals.map((genital) => (
                <Tabs.Tab
                  key={genital.ref}
                  selected={genital.ref === selected}
                  onClick={() => act('select_organ', { ref: genital.ref })}
                >
                  {genital.name}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>
            {selected ? (
              <Stack fill>
                <Stack.Item grow basis={0}>
                  <Section title="Visibility" fill>
                    {visibility_options.map((option) => (
                      <Button
                        key={option}
                        fluid
                        selected={option === visibility}
                        onClick={() => act('set_visibility', { option })}
                      >
                        {option}
                      </Button>
                    ))}
                  </Section>
                </Stack.Item>
                {!!custom && (
                  <Stack.Item grow basis={0}>
                    <Section title="Layering" fill>
                      {layering_options.map((option) => (
                        <Button
                          key={option}
                          fluid
                          selected={option === layering}
                          onClick={() => act('set_layering', { option })}
                        >
                          {option}
                        </Button>
                      ))}
                    </Section>
                  </Stack.Item>
                )}
              </Stack>
            ) : (
              <NoticeBox>Nothing to configure.</NoticeBox>
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
